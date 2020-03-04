class AddressesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @address = Address.new()
  end

  def create
    @address = Address.new(params_address)
    @address.user = User.find(params[:user_id])
    if @address.save
      if @address.active == true
        current_user.addresses.where.not(id: params[:id]).update_all(active: false)
      end
      redirect_to root_path
    else
      render :new
    end
  end

  def create_from_coordinates
    @address = Address.new(params_address)
    @address.user = current_user
    results = Geocoder.search([@address.latitude, @address.longitude])
    @address.full_address = results.first.address
    @address.name = "Other"
    @address.active = true
    if @address.save
      current_user.addresses.where.not(id: params[:id]).update_all(active: false)
    end
    redirect_to root_path
  end

  def index
    @new_address = Address.new()
    @addresses = current_user.addresses
    @user = current_user
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(params_address)
      if @address.active == true
        current_user.addresses.where.not(id: params[:id]).update_all(active: false)
      end
      redirect_to root_path
    else
      render :new
    end
  end

  def update_from_participants
    @address = Address.find(params[:address])
    @user = User.find(params[:user_id])
    @participant = Participant.find(params[:participant])
    @event = Event.find(params[:event])
    @participant.update(address: @address)
    @address.update!(active: true)
    @user.addresses.where.not(id: params[:address]).update_all(active: false)
    redirect_to new_event_participant_path(@event)
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to user_addresses_path
  end

  private

  def params_address
    params.require(:address).permit(:name, :full_address, :active, :latitude, :longitude)
  end

end
