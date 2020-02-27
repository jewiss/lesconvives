class ParticipantsController < ApplicationController
  def new
    @participants = Participant.new()
    @event = Event.find(params[:event_id])
    raise

    @event.participants.each do |participant|
      coordinates = []
      coordinates << participant.address.latitude.to_f
      coordinates << participant.address.longitude.to_f
      @markers = @markers << { lat: coordinates[0], lng: coordinates[1], icon: ActionController::Base.helpers.asset_url('avatar.png')}
    end

    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end

  def create
  end

  def destroy
  end
end
