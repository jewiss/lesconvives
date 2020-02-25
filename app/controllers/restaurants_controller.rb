require 'json'
require 'open-uri'
# api_key='AIzaSyAHPB_XgGpd8N7bomLX-AxRKXatr1PSIF4'

class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
    geographic_center
    directions_to_geographic_center
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

  def directions_to_geographic_center
    @participants = Participant.all
    @participants.each do |participant|
      url = "https://maps.googleapis.com/maps/api/directions/json?&origin=#{participant.address.latitude.to_f},#{participant.address.longitude.to_f}&destination=#{geographic_center[0]},#{geographic_center[1]}&mode=transit&key=AIzaSyAHPB_XgGpd8N7bomLX-AxRKXatr1PSIF4"
      directions_serialized = open(url).read
      directions = JSON.parse(directions_serialized)
      raise
    end
  end

end
