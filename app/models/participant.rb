class Participant < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :address
  has_many :votes, dependent: :destroy
end
