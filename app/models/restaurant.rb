class Restaurant < ApplicationRecord
  has_many :selected_restaurants
  validates :name, presence: true
end
