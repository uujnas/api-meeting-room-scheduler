class Schedule < ApplicationRecord
  belongs_to :meeting

  validates_presence_of :date, :start_time, :end_time

  after_initialize do
    start_time = Time.parse(self.start_time.to_s)
    self.start_time = start_time.strftime('%H:%M %p')
  end
end
