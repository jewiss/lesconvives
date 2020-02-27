class EventsController < ApplicationController
  def create
    @event = Event.new(event_params)
    if @event.save
      Participant.create(user: current_user, event: @event, owner: true, attending: true, address: current_user.addresses.first )
      # Participant.create(user: current_user, event: @event, owner: true, attending: true, address: current_user.addresses.first )
      redirect_to new_event_participant_path(@event)
    else
      redirect_to root_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date)
  end
end

