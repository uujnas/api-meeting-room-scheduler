require 'rails_helper'

RSpec.describe Room, type: :model do
  current_user = User.first_or_create!(email: 'sanjubasnet@gmail.com', password: 'password', role: 'admin', address: 'new york', contact: '976543210')

  it 'has a desc' do
    room = Room.new(
      desc: '',
      user: current_user
    )
    expect(room).to_not be_valid
    room.desc = 'Ongoing meeting is about Unit testing with SS team'
    expect(room).to be_valid
  end
end
