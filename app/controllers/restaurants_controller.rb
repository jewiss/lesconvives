require 'json'
require 'open-uri'


class RestaurantsController < ApplicationController

  def index
    lng = 2.379717
    lat = 48.865433
    @results_restaurants = parse_google_api(lat, lng)

    @restaurants = Restaurant.all
    geographic_center
    directions_to_geographic_center

  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

 def parse_google_api(lat, lng)
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=1000&type=restaurant&key=#{ENV["GOOGLE_MAPS_TOKEN"]}"
    restaurants_serialized = open(url).read
    restaurants = JSON.parse(restaurants_serialized)["results"]
    final_restaurants = restaurants.map do |restaurant|
      resto = Restaurant.find_or_create_by(google_api_id: restaurant["id"]) do |r|
        r.name = restaurant["name"]
        r.price_level = restaurant["price_level"]
        r.rating = restaurant["rating"]
        r.address = restaurant["vicinity"]
        r.google_api_id = restaurant["id"]

      end
      res = Net::HTTP.get_response(URI("https://maps.googleapis.com/maps/api/place/photo?key=#{ENV["GOOGLE_MAPS_TOKEN"]}&photoreference=#{restaurant["photos"][0]["photo_reference"]}&maxwidth=400"))
      resto.photo_url = res['location']
      resto.save!
      resto

    end

    return final_restaurants
  end


  def geographic_center
    retrive_participants_geo_positions
    geo_positions = []
    @participants = Participant.all
    @participants.each do |participant|
      coordinates = []
      coordinates << participant.address.latitude.to_f
      coordinates << participant.address.longitude.to_f
      geo_positions << coordinates
    end
    find_geographic_center
    geographic_center = Geocoder::Calculations.geographic_center(geo_positions)
  end

  def directions_to_geographic_center
    @participants = Participant.all
    @participants.each do |participant|
      url = "https://maps.googleapis.com/maps/api/directions/json?&origin=#{participant.address.latitude.to_f},#{participant.address.longitude.to_f}&destination=#{geographic_center[0]},#{geographic_center[1]}&mode=transit&key=AIzaSyAHPB_XgGpd8N7bomLX-AxRKXatr1PSIF4"
      directions_serialized = open(url).read
      directions = JSON.parse(directions_serialized)
    end
  end


end

