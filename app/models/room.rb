class Room < ApplicationRecord
  belongs_to :user
  validates :desc, presence: true
end
