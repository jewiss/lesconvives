class SelectedRestaurantsController < ApplicationController

  def create
    SelectedRestaurant.create!(restaurant_id: params[:restaurant_id], event_id: params[:event_id])
  end

end
