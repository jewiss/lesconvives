class Vote < ApplicationRecord
  belongs_to :participant
  belongs_to :selected_restaurant
end
