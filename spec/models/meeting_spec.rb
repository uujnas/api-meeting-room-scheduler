require 'rails_helper'

RSpec.describe Meeting, type: :model do
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

  context 'meeting' do
    it 'should exist room' do
      meeting = Meeting.new

      expect(meeting).to_not be_valid
    end

    it 'subject should be present' do
      meeting = Meeting.new(
        subject: 'this is subject',
        room: room
      )

      expect(meeting.valid?).to be_truthy

      expect(meeting).to be_valid
    end

    it 'subject must have at least 5 character' do
      meeting = Meeting.new(
        subject: '',
        room: room
      )

      # expect(meeting.errors[:subject]).to include('Subject is too short (minimum is 5 characters)')
      expect(meeting).to_not be_valid

      meeting.subject = 'test'

      expect(meeting.errors.present?).to be_truthy

      meeting.subject = "This is meeting title"

      expect(meeting).to be_valid
    end
  end

  context 'association' do
    it { should belong_to(:room).class_name('Room') }

    it { should have_one(:schedule).class_name('Schedule') }
  end
end
