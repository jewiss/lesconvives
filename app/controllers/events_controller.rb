class EventsController < ApplicationController
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to new_event_participant_path(@event)
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date)
  end
end

