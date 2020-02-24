class Event < ApplicationRecord
  has_many :selected_restaurants, dependent: :destroy
  has_many :participants, dependent: :destroy
  validates :name, :date, presence: true
end
