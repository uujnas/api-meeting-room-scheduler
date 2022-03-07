require 'rails_helper'

RSpec.describe 'Schedules', type: :request do
  let(:valid_attributes) do
    {
      date: '2022-03-05',
      start_time: '11:00 AM',
      end_time: '01:30 PM',
      meeting_id: create_meeting.id
    }
  end
  let(:invalid_attributes) do
    {
      subject: 'test',
      room_id: nil
    }
  end

  describe 'GET /index' do
    it 'should return 200/success/ok' do
      get '/rooms/:2/meetings/2/schedules'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'should return status ok' do
      get '/rooms/2/meetings/2/schedules/10'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'should return status created' do
        expect do
          # schedule = Schedule.new(valid_attributes)
          # schedule.save!
          post '/rooms/2/meetings/2/schedules', params: { schedule: valid_attributes }
        end.to change(Schedule, :count).by(1)

        # expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns status 201 with null id' do
        expect do
          schedule = Schedule.new(invalid_attributes)
          schedule.save
          post '/rooms/2/meetings/2/schedules', params: { schedule: invalid_attributes }
        end
      end
    end
  end
  describe 'Update /patch' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          start_time: '12:00 AM',
          end_time: '02:30 PM'
        }
        it 'updates the requested schedule' do
          schedule = Schedule.new(valid_attributes)
          schedule.save!
          patch '/rooms/2/meetings/2/schedules/8', params: { schedule: new_attributes }
          meeting.reload
          skip('Add assertions for update state')
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'should remove the meeting' do
      schedule = Schedule.new(valid_attributes)
      schedule.save
      expect do
        delete '/rooms/2/meetings/2/schedules/8'
      end.to change(Schedule, :count).by(-1)
    end
  end
end
