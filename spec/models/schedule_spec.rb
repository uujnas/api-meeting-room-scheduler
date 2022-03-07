require 'rails_helper'

RSpec.describe Schedule, type: :model do
  user = User.first_or_create!(
    email: 'bikash@gmail.com',
    password: 'mypassword',
    role: 'admin',
    address: 'Baishdhara',
    contact: '9865183709'
  )

  room = Room.first_or_create!(
    desc: 'meeting room1',
    user: user
  )

  meeting = Meeting.first_or_create!(
    subject: 'meeting subject',
    room: room
  )
  puts meeting.id

  subject do
    described_class.new(
      date: '2022-03-10',
      start_time: '11:00 AM',
      end_time: '01:30 PM',
      meeting: meeting
    )
  end

  before { subject.save }

  context 'schedule' do
    it 'date should present' do
      subject.date = nil

      expect(subject).to_not be_valid

      subject.date = '2022-03-06'
      expect(subject).to be_valid
    end

    it 'start time should present' do
      subject.start_time = nil
      expect(subject).to_not be_valid

      subject.start_time = '11:00 AM'
      expect(subject).to be_valid
    end

    it 'end time should present' do
      subject.end_time = nil
      expect(subject).to_not be_valid

      subject.end_time = '01:30 PM'
      expect(subject).to be_valid
    end
  end

  context 'association' do
    it { should belong_to(:meeting).class_name('Meeting') }
  end
end
