class ParticipantsController < ApplicationController
  def new
    @participant = Participant.new()
    @event = Event.find(params[:event_id])
    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end

  def create
    @participant = Participant.new(event_id: params[:event_id], user_id: params[:user])
    @participant.address = @participant.user.addresses.find_by(name: 'Work')
    @participant.save
    redirect_to new_event_participant_path
  end

  def destroy
  end


end
