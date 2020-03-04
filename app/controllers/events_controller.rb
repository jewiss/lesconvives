class EventsController < ApplicationController
  def create
    @event = Event.new(event_params)
    if @event.save
      Participant.create!(user: current_user, event: @event, owner: true, attending: true, address: current_user.addresses.find_by(active: true))
      redirect_to new_event_participant_path(@event)
    else
      @user = current_user
      render "users/show"
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :hour)
  end
end

