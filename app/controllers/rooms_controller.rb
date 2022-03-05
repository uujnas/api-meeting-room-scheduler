class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    rooms = Room.all
    render json: rooms
  end

end
