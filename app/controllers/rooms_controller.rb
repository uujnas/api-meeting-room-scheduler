class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_room, only: %i[show update destroy]

  def index
    rooms = Room.all
    render json: rooms, status: :ok
  end

  def show
    render json: @room, status: :ok
  end

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

  def update
    if is_admin?
      @room.update(room_params)
      render json: { message: 'Record Updated.', room: @room }, status: :ok
    else
      render json: { message: 'You are not allowed to update this record.' }, status: :unauthorized
    end
  end

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
