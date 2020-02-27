class Restaurant < ApplicationRecord
  has_many :selected_restaurants
  validates :name, presence: true
  has_one_attached :photo
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode, if: :will_save_change_to_address?
  CATEGORY = ["indian"]
  RATINGS = { "Rating choice"=> nil, "★" => 1, "★★" => 2, "★★★" => 3, "★★★★" => 4, "★★★★★" => 5 }
  PRICE_LEVEL = { "Price choice"=> nil, "€" => 1, "€€" => 2, "€€€" => 3, "€€€€" => 4, "€€€€€" => 5 }
end
