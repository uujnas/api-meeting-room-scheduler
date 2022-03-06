class Meeting < ApplicationRecord
  belongs_to :room

  has_one :schedule, dependent: :destroy
end
