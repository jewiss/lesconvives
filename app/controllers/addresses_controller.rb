class AddressesController < ApplicationController

  def new
    @user = current_user
    @address = Address.new()
  end

  def create
    @address = Address.new(params_address)
    if @address.save
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
    current_user.addresses.each { |address| address.active = false }
    @address.active = true
    @address.save!
    redirect_to root_path
  end

  def edit
    @new_address = Address.new()
    @addresses = current_user.addresses
    @address = Address.find(params[:id])
    @user = current_user
  end

  def update
    @address = Address.find(params[:id])
    @address.update(params_address)
    if @address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def params_address
    params.require(:address).permit(:name, :full_address, :active, :latitude, :longitude)
  end

end
