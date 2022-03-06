class Room < ApplicationRecord
  belongs_to :user
  validates :desc, presence: true

  has_many :meetings, dependent: :destroy
end
