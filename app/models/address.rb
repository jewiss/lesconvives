class Address < ApplicationRecord
  belongs_to :user
  has_many :participants
  geocoded_by :full_address
  # reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode, if: :will_save_change_to_full_address?
end
