class ParticipantsController < ApplicationController
  def new
    @participants = Participant.new()
    @event = Event.find(params[:event_id])
  end

  def create
  end

  def destroy
  end
end
