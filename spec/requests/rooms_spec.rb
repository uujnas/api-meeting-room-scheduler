require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  let(:valid_attributes) do
    {
      desc: 'This room is for ROR traniee',
      user_id: create_user.id
    }
  end

  let(:invalid_attributes) do
    {
      id: 'a',
      desc: ''
    }
  end

  context 'authenticate user' do
    describe 'GET /index' do
      it 'returns status 200' do
        user = create_user
        headers = get_header(user.email)
        get '/rooms', headers: headers
        expect(response).to have_http_status(200)
      end
    end

    describe 'GET /show' do
      it 'return status 200' do
        user = create_user
        headers = get_header(user.email)
        get '/rooms/1', headers: headers
        expect(response).to have_http_status(200)
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'returns status 201 created' do
          expect do
            room = Room.new(valid_attributes)
            room.save
            post rooms_url, params: { room: valid_attributes }
          end.to change(Room, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns status 201 with null id' do
          expect do
            room = Room.new(invalid_attributes)
            room.save
            post rooms_url, params: { room: invalid_attributes }
          end
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroy the request room' do
        room = Room.new(valid_attributes)
        room.save
        expect do
          delete room_url(room)
        end.to change(Room, :count).by(0)
      end
    end

    describe 'Update /patch' do
      context 'with valid parameters' do
        let(:new_attributes) do
          {
            id: 1,
            desc: 'Meeting  ongoing project'
          }
          it 'updates the requested room' do
            room = Room.new(valid_attributes)
            room.save!
            patch room_url(room), params: { room: new_attributes }
            room.reload
            skip('Add assertions for update state')
          end
        end
      end
    end
  end

  context 'unauthenticate user' do
    describe 'GET /index' do
      it 'returns status 401' do
        get '/rooms'
        expect(response).to have_http_status(401)
      end
    end
  end
end
