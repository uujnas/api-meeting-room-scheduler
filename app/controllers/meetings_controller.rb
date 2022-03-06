class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show update destroy ]

  def index
    @meetings = Meeting.all

    render json: @meetings, status: :ok
  end

  def show
    render json: @meeting, status: :ok
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.room_id = params[:room_id]

    if @meeting.save
      render json: @meeting, status: :created
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  def update
    if @meeting.update(meeting_params)
      render json: @meeting
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @meeting.destroy
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:subject, :members, :room_id)
  end
end
