require 'rails_helper'

RSpec.describe Meeting, type: :model do

  context 'association' do
    it { should belong_to(:room).class_name('Room') }

    it { should have_one(:schedule).class_name('Schedule') }
  end
end