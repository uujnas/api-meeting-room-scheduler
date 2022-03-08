##
# The RoomsController is used for handling incoming requests for room.
class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_room, only: %i[show update destroy]

  # Returns all the available rooms for the authenticated user only.
  ## GET /rooms
  def index
    rooms = Room.all
    render json: rooms, status: :ok
  end

  # Returns the details of the room when room id is provided.
  ## GET /rooms/:id
  def show
    render json: @room, status: :ok
  end

  # Creates a new room with provided params and return 'Room Created Successfully' when room is created.
  # Only the admin has the privileges to create room.
  ## POST /rooms
  def create
    if is_admin?
      room = Room.new(room_params)
      room.user_id = current_user.id
      room.save
      render json: { messages: 'Room Created Successfully.', room: room }, status: :created
    else
      render json: { message: 'You are not allowed to create room.' }, status: :unauthorized
    end
  end

  # Update room details (only for admin).
  ## PUT/ PATCH /rooms/:id
  def update
    if is_admin?
      @room.update(room_params)
      render json: { message: 'Record Updated.', room: @room }, status: :ok
    else
      render json: { message: 'You are not allowed to update this record.' }, status: :unauthorized
    end
  end

  # Removes the room(only for admin)
  ## DELETE /rooms/:id
  def destroy
    if is_admin?
      @room.destroy
      render json: { message: 'Record Deleted.' }, status: :ok
    else
      render json: { message: 'You are not allowed to remove this record.' }, status: :unauthorized
    end
  end

  private

  def room_params
    params.require(:room).permit(:desc)
  end

  # Checks whether the logged in user is admin or not.
  def is_admin?
    current_user.admin?
  end

  def find_room
    @room = begin
      Room.find(params[:id])
    rescue StandardError
      { message: 'record not found.' }
    end
  end
end
