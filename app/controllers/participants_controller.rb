class ParticipantsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])

    @markers = []
    @event.participants.each do |participant|
      if participant.user.profile_picture.attached?
        icon = { url: ActionController::Base.helpers.cl_image_path(participant.user.profile_picture.key, transformation: [{radius: 'max'}]), scaledSize: { width: 50, height: 50} }
      else
        icon = { url: (participant.user.facebook_picture_url || "http://placehold.it/50x50"), scaledSize: { width: 50, height: 50} }
      end
      coordinates = []
      coordinates << participant.address.latitude.to_f
      coordinates << participant.address.longitude.to_f
      @markers = @markers << { lat: coordinates[0], lng: coordinates[1], icon: icon, infoWindow: { content: render_to_string(partial: "/participants/infowindow_address", locals: { participant: participant }) } }
    end

    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end

  def create
    @participant = Participant.new(event_id: params[:event_id], user_id: params[:user])
    @participant.address = @participant.user.addresses.find_by(active: true)
    @participant.save
    redirect_to new_event_participant_path(:anchor => "anchor")
  end

  def destroy
    @participant = Participant.find(params[:id])
    @event = @participant.event
    @participant.destroy
    redirect_to new_event_participant_path(@event, :anchor => "anchor")
  end

end
