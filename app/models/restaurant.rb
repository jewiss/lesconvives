class Restaurant < ApplicationRecord
  has_many :selected_restaurants
  validates :name, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
