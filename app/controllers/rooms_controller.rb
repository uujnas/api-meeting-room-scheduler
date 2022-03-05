class RoomsController < ApplicationController
  before_action :authenticate_user!
  # before_action :is_admin?, only: %i[create]

  def index
    rooms = Room.all
    render json: rooms, status: :ok
  end

  def create
    if is_admin?
      room = Room.new(room_params)
      room.user_id = current_user.id
      room.save
      render json: { messages: 'Room Created Successfully', room: room }, status: :ok
    else
      render json: { message: 'You are not allowed to create room' }, status: :unauthorized
    end
  end

  private

  def room_params
    params.require(:room).permit(:desc)
  end

  def is_admin?
    p current_user
    current_user.admin?
  end
end
