class Meeting < ApplicationRecord
  belongs_to :room

  has_one :schedule, dependent: :destroy

  validates :subject, presence: true, length: { minimum: 5 }

  before_save do
    self.subject = self.subject.titleize
  end
end
