class UsersController < ApplicationController
  def show
    @user = current_user
    @facebook_photo = current_user.facebook_picture_url
    @event = Event.new()
  end
end
