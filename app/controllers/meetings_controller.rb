class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show update destroy ]

  def index
    @meetings = Meeting.where(room_id: params[:room_id])

    render json: @meetings, status: :ok
  end

  def show
    render json: @meeting, status: :ok
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.room_id = params[:room_id]

    if @meeting.save
      save_members
      render json: @meeting, status: :created
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  def update
    if @meeting.update(meeting_params)
      save_members
      render json: @meeting
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @meeting.destroy
  end

  def all_meetings
    @meetings = Meeting.all
    render json: @meetings, status: :ok
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:subject, :room_id, :members=> [:email])
  end

  def save_members
    params[:meeting][:members].each do |member|
      puts member
      @meeting.members.push member
    end
    @meeting.save!
  end
end
