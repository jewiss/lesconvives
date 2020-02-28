class Event < ApplicationRecord
  has_many :selected_restaurants, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  validates :name, :date, presence: true
end
