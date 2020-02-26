require 'json'
require 'open-uri'

class RestaurantsController < ApplicationController

  def index
    lng = 2.379717
    lat = 48.865433
    @results_restaurants = parse_google_api(lat, lng)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def parse_google_api(lat, lng)
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=1000&type=restaurant&key=AIzaSyAHPB_XgGpd8N7bomLX-AxRKXatr1PSIF4"
    restaurants_serialized = open(url).read
    restaurants = JSON.parse(restaurants_serialized)["results"]
    final_restaurants = restaurants.map do |restaurant|
      Restaurant.find_or_create_by(google_api_id: restaurant["id"]) do |resto|
        resto.name = restaurant["name"]
        resto.price_level = restaurant["price_level"]
        resto.rating = restaurant["rating"]
        resto.address = restaurant["vicinity"]
        resto.google_api_id = restaurant["id"]
        file = URI.open("https://maps.googleapis.com/maps/api/place/photo?key=AIzaSyAHPB_XgGpd8N7bomLX-AxRKXatr1PSIF4&photoreference=#{restaurant["photos"][0]["photo_reference"]}&maxwidth=400")
        resto.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
      end
    end

    return final_restaurants

  end


end


# url pour recuperer photo
# https://lh3.googleusercontent.com/p/AF1QipO8VERZZG1DP2DVaaqliwvomk8agqq0LNceljCb=s1600-w400
