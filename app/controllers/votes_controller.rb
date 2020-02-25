class VotesController < ApplicationController
  def new
  	@selected_restaurant = SelectedRestaurant.find(params[:selected_restaurant_id])
    @partcicipant = Partcicipant.find(params[:participant_id])
    @participant = current_user
    @vote = Vote.new
  end

  def create
  	@vote = Vote.new(votes_params)
  	@selected_restaurant = SelectedRestaurant.find(params[:selected_restaurant_id])
  	@participant = current_user
  	@vote.selected_restaurant = @selected_restaurant
  end

  def show
  	@vote = Vote.find(params[:id])
  end

  private

  def votes_params
  	params.require(:vote).permit(:created_at, :updated_at, :participant_id, :selected_restaurant_id)

  end
end


