class Room < ApplicationRecord
  belongs_to :user
  validates :desc, presence: true

  has_many :schedules, dependent: :destroy
end
