class ParticipantsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])

    @markers = []
    @event.participants.each do |participant|
      if participant.user.profile_picture.attached?
        icon = { url: participant.user.profile_picture.key, scaledSize: { width: 50, height: 50, borderRadius: '50px'} }
      else
        icon = { url: (participant.user.facebook_picture_url || "http://placehold.it/30x30"), scaledSize: { width: 50, height: 50} }
      end
      # raise
      # icon = participant.user.profile_picture.attached? ?
      coordinates = []
      coordinates << participant.address.latitude.to_f
      coordinates << participant.address.longitude.to_f
      @markers = @markers << { lat: coordinates[0], lng: coordinates[1], icon: icon }
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
    @participant.address = @participant.user.addresses.find_by(name: 'Home')
    @participant.save
    redirect_to new_event_participant_path
  end

  def destroy
    @participant = Participant.find_by(user_id: params[:user])
    raise
    @participant.destroy
  end


end
