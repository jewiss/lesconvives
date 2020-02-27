class Address < ApplicationRecord
  belongs_to :user
  has_many :participants
  geocoded_by :full_address
  after_validation :geocode, :reverse_geocode, if: :will_save_change_to_full_address?
end
