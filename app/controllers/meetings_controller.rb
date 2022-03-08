##
# Accepts and handles the incoming requests for Meetings.
class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show update destroy]

  # Returns all available meetings for a particular room(based on room id).
  ##
  ## GET /rooms/:room_id/meetings
  def index
    @meetings = Meeting.where(room_id: params[:room_id])

    render json: @meetings, status: :ok
  end

  # Returns the details of meeting when meeting id is provided.
  ## GET /rooms/:room_id/meetings/:id
  def show
    render json: @meeting, status: :ok
  end

  # Create a new meeting with the provided params.
  ## POST /rooms/:room_id/meetings
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

  # Update meeting details either fully or partially.
  ## PUT/PATCH /rooms/:room_id/meetings/:id
  def update
    if @meeting.update(meeting_params)
      save_members
      render json: @meeting
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  # Remove the meeting details based on provided room id and meeting id
  ## DELETE /rooms/:room_id/meetings/:id
  def destroy
    @meeting.destroy
  end

  # Returns all available meetings
  ## GET /rooms/meetings
  def all_meetings
    @meetings = Meeting.all
    render json: @meetings, status: :ok
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:subject, :room_id, members: [:email])
  end

  def save_members
    params[:meeting][:members].each do |member|
      puts member
      @member = @meeting.members.push member
      MemberMailer.members_added_on_meeting(@member, @meeting).deliver_now if @meeting.save!
    end
  end
end
