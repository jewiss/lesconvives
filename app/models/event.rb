class Event < ApplicationRecord
  has_many :selected_restaurants
  has_many :participants
end
