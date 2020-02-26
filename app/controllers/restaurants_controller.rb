require 'json'
require 'open-uri'
# api_key='AIzaSyAHPB_XgGpd8N7bomLX-AxRKXatr1PSIF4'

class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
    @geographic_center = geographic_center
    @directions = directions_to_geographic_center_distance_matrix_api
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def geographic_center
    #retrive_participants_geo_positions
    geo_positions = []
    @participants = Participant.all
    @participants.each do |participant|
      coordinates = []
      coordinates << participant.address.latitude.to_f
      coordinates << participant.address.longitude.to_f
      geo_positions << coordinates
    end
    #find_geographic_center
    geographic_center = Geocoder::Calculations.geographic_center(geo_positions)
  end

  # def directions_to_geographic_center_directions_api
  #   @participants = Participant.all
  #   @participants.each do |participant|
  #     url = "https://maps.googleapis.com/maps/api/directions/json?&origin=#{participant.address.latitude.to_f},#{participant.address.longitude.to_f}&destination=#{geographic_center[0]},#{geographic_center[1]}&mode=transit&key=AIzaSyAHPB_XgGpd8N7bomLX-AxRKXatr1PSIF4"
  #     directions_serialized = open(url).read
  #     directions = JSON.parse(directions_serialized)
  #   end
  # end

  def directions_to_geographic_center_distance_matrix_api
    @participants = Participant.all
    directions = {}
    @participants.each do |participant|
      url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{participant.address.latitude},#{participant.address.longitude}&destinations=#{geographic_center[0]},#{geographic_center[1]}&mode=transit&units=metric&key=AIzaSyAHPB_XgGpd8N7bomLX-AxRKXatr1PSIF4"
      directions_serialized = open(url).read
      parsed_directions = JSON.parse(directions_serialized)
      transit_duration = parsed_directions['rows'].first['elements'].first['duration']['text']
      transit_distance = parsed_directions['rows'].first['elements'].first['distance']['text']
      # raise
      directions[participant] = {
        transit_duration: transit_duration,
        transit_distance: transit_distance
      }
    end
    return directions
  end

end
