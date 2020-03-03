class AddressesController < ApplicationController

  def new
    @user = current_user
    @address = Address.new()
  end

  def create
    @address = Address.new(params_address)
    if @address.active = true
      current_user.addresses.each { |address| address.active = false }
      @address.active = true
    end
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

  def index
    @new_address = Address.new()
    @addresses = current_user.addresses
    @user = current_user
  end

  def update
    @address = Address.find(params[:id])
    if @address.active = true
      current_user.addresses.each { |address| address.active = false }
      @address.active = true
    end
    if @address.update(params_address)
      redirect_to root_path
    else
      render :new
    end
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
