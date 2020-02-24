class SelectedRestaurant < ApplicationRecord
  belongs_to :restaurant
  belongs_to :event
  has_many :votes
end
