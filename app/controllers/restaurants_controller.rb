require 'json'
require 'open-uri'

class RestaurantsController < ApplicationController

  def index
    if params[:food_category].present?
      food_category = params[:food_category]
    else
      food_category = ""
    end
    @geographic_center = geo_center_to_address(geographic_center)
    @directions = directions_to_geographic_center_distance_matrix_api
    @lat = geographic_center[0]
    @lng = geographic_center[1]

# si pas de params ou si params food category
    if params[:food_category].present? || Restaurant.near(geographic_center, 0.1).empty?
      @results_restaurants = parse_google_api(@lat, @lng, food_category)
      @details_restaurants = parse_restaurant_details_api(@results_restaurants)
      if params[:rating].present?
        @results_restaurants = @results_restaurants.select {|r| r.rating == params[:rating].to_i}
      end
      if params[:price_level].present?
        @results_restaurants = @results_restaurants.select {|r| r.price_level == params[:price_level].to_i}
      end
    else

      @results_restaurants = Restaurant.near(geographic_center, 0.1).limit(20)
      if params[:rating].present?
        @results_restaurants = @results_restaurants.where(rating: params[:rating])
      end
      if params[:price_level].present?
        @results_restaurants = @results_restaurants.where(price_level: params[:price_level])
      end
    end
    @markers = @results_restaurants.select {|r| r.latitude.present? && r.longitude.present? && r.photo.present? }.map do |restaurant|
        {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        details: {
          name: restaurant.name,
          rating: restaurant.rating,
          short_address: restaurant.short_address,
          photo_key: restaurant.photo.key,
          price_level: restaurant.price_level.to_i
        }

        # icon: ActionController::Base.helpers.asset_url('restaurant.png')
        #infoWindow: { content: render_to_string(partial: "/restaurants/infowindow", locals: { restaurant: restaurant }) }
      }
    end
# markers for geocenter
    @markers = @markers << { lat: @lat, lng: @lng, icon: ActionController::Base.helpers.asset_url('center.png'), infoWindow: { content: render_to_string(partial: "/restaurants/infowindowcenter", locals: { center: @shortened_address }) } }

# markers for each participant
    @participants.each do |participant|
      coordinates = []
      coordinates << participant.address.latitude.to_f
      coordinates << participant.address.longitude.to_f
      if participant.user.profile_picture.attached?
        icon = { url: ActionController::Base.helpers.cl_image_path(participant.user.profile_picture.key, transformation: [{radius: 'max'}]), scaledSize: { width: 50, height: 50, borderRadius: '50px'} }
      else
        icon = { url: (participant.user.facebook_picture_url || "http://placehold.it/30x30"), scaledSize: { width: 50, height: 50, borderRadius: '50px'} }
      end
      @markers = @markers << { lat: coordinates[0], lng: coordinates[1], icon: icon }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def parse_google_api(lat, lng, food_category)
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=#{food_category}&location=#{lat},#{lng}&radius=200&type=restaurant&key=#{ENV["GOOGLE_MAPS_TOKEN"]}"
    restaurants_serialized = open(url).read
    restaurants = JSON.parse(restaurants_serialized)["results"]
    final_restaurants = restaurants.map do |restaurant|
      resto = Restaurant.find_or_create_by(google_api_id: restaurant["id"]) do |r|
        r.name = restaurant["name"]
        r.price_level = restaurant["price_level"]
        r.rating = restaurant["rating"]
        r.address = restaurant["vicinity"]
        r.short_address = restaurant["vicinity"]
        r.google_api_id = restaurant["id"]
        r.place_id_google = restaurant["place_id"]
      end
      if restaurant["photos"] && !resto.photo.attached?
        res = Net::HTTP.get_response(URI("https://maps.googleapis.com/maps/api/place/photo?key=#{ENV["GOOGLE_MAPS_TOKEN"]}&photoreference=#{restaurant["photos"][0]["photo_reference"]}&maxwidth=400"))
        file = URI.open(res['location'])
        resto.photo.attach(io: file, filename: "#{restaurant["id"]}.jpg", content_type: 'image/jpg')
      end

      if food_category != ""
        resto.food_category = "#{food_category}"
      end
      resto.save!
      resto
    end
    return final_restaurants
  end

  def parse_restaurant_details_api(final_restaurants)
    @restaurants = final_restaurants
    @restaurants.each do |restaurant|
      url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{restaurant.place_id_google}&key=#{ENV["GOOGLE_MAPS_TOKEN"]}"
      restaurants_serialized = open(url).read
      restaurants = JSON.parse(restaurants_serialized)["result"]
      if restaurants != nil
        resto = Restaurant.find_or_create_by(google_api_id: restaurants["id"])
        resto.opening_hours = restaurants["opening_hours"]["weekday_text"] if restaurants["opening_hours"]
        resto.url = restaurants["website"]
        resto.phone = restaurants["formatted_phone_number"]
        resto.save!
        resto
      end
    end
    return @restaurants
  end

  def geographic_center
    # retrive_participants_geo_positions
    @event = Event.find(params[:event])
    @geo_positions = []
    @participants = @event.participants
    @participants.each do |participant|
      coordinates = []
      coordinates << participant.address.latitude.to_f
      coordinates << participant.address.longitude.to_f
      @geo_positions << coordinates
    end
    # find_geographic_center
    geographic_center = Geocoder::Calculations.geographic_center(@geo_positions)
  end

  def geo_center_to_address(geo_center)
    results = Geocoder.search([geo_center[0], geo_center[1]])
    if results.any?
      @full_address = results.first.data['address']
      if @full_address['road'].nil?
        road = @full_address['way']
      else
        road = @full_address['road']
      end
      @shortened_address = "#{road}, #{@full_address['postcode']}, #{@full_address['city']}"
    end
    return @shortened_address
  end

  # def directions_to_geographic_center_directions_api
  #   @participants = Participant.all
  #   @participants.each do |participant|
  #     url = "https://maps.googleapis.com/maps/api/directions/json?&origin=#{participant.address.latitude.to_f},#{participant.address.longitude.to_f}&destination=#{geographic_center[0]},#{geographic_center[1]}&mode=transit&key=#{ENV["GOOGLE_MAPS_TOKEN"]}"
  #     directions_serialized = open(url).read
  #     directions = JSON.parse(directions_serialized)
  #   end
  # end

  def directions_to_geographic_center_distance_matrix_api
    @event = Event.find(params[:event])
    @participants = @event.participants
    directions = {}
    @participants.each do |participant|
      url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{participant.address.latitude},#{participant.address.longitude}&destinations=#{geographic_center[0]},#{geographic_center[1]}&mode=transit&units=metric&key=#{ENV["GOOGLE_MAPS_TOKEN"]}"
      directions_serialized = open(url).read
      parsed_directions = JSON.parse(directions_serialized)
      transit_duration = parsed_directions['rows'].first['elements'].first['duration']['text']
      transit_distance = parsed_directions['rows'].first['elements'].first['distance']['text']
      directions[participant] = {
        transit_duration: transit_duration,
        transit_distance: transit_distance
      }
    end
    return directions
  end
end

