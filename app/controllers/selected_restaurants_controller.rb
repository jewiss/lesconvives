class SelectedRestaurantsController < ApplicationController

  def create
    SelectedRestaurant.create!(restaurant_id: params[:restaurant], event_id: params[:event])
  end

end
