class ParticipantsController < ApplicationController
  def new
    @participants = Participant.new()
    @event = Event.find(params[:event_id])
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
