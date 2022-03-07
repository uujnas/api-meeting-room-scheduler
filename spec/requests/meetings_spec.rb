require 'rails_helper'

RSpec.describe 'Meetings', type: :request do
  let(:valid_attributes) do
    {
      subject: 'ROR Trainee',
      room_id: create_room.id,
      members: [
        'shresthabikash2073@gmail.com',
        'sanju@gmail.com'
      ]
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
      get '/rooms/:2/meetings'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /all_meetings' do
    it 'should return status ok' do
      get '/rooms/meetings'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'should return status ok' do
      get '/rooms/2/meetings/2'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'should return status created' do
        expect do
          meeting = Meeting.new(valid_attributes)
          meeting.save!
          post '/rooms/2/meetings', params: { meeting: valid_attributes }
        end.to change(Meeting, :count).by(1)

        # expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns status 201 with null id' do
        expect do
          meeting = Meeting.new(invalid_attributes)
          meeting.save
          post '/rooms/2/meetings', params: { meeting: invalid_attributes }
        end
      end
    end

    describe 'Update /patch' do
      context 'with valid parameters' do
        let(:new_attributes) do
          {
            subject: 'ROR Trainee - Git Session'
          }
          it 'updates the requested meeting' do
            meeting = Meeting.new(valid_attributes)
            meeting.save!
            patch '/rooms/2/meetings/2', params: { meeting: new_attributes }
            meeting.reload
            skip('Add assertions for update state')
          end
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'should remove the meeting' do
        meeting = Meeting.new(valid_attributes)
        meeting.save
        expect do
          delete '/rooms/2/meetings/2'
        end.to change(Meeting, :count).by(-1)
      end
    end
  end
end
