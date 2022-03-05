class Schedule < ApplicationRecord
  belongs_to :room

  validates :title, presence: true, length: { minimum: 5 }
  validates_presence_of :date, :start_time, :end_time

  after_initialize do
    start_time = Time.parse(self.start_time.to_s)
    self.start_time = start_time.strftime('%H:%M %p')
    self.title = title.titleize
  end
end
