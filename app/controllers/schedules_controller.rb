##
# Accepts and handles the incoming requests for Schedules.
class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show update destroy]

  # Returns all available schedules.
  ##
  ## GET /rooms/:room_id/meetings/:meeting_id/schedules
  def index
    @schedules = Schedule.all

    render json: @schedules
  end

  # Returns schedule details of provided id.
  ## GET /rooms/:room_id/meetings/:meeting_id/schedules/:id
  def show
    render json: @schedule
  end

  # Creates schedule of meeting when the meeting id is provided.
  ## POST /rooms/:room_id/meetings/:meeting_id/schedules
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.meeting_id = params[:meeting_id]

    if @schedule.save
      render json: @schedule, status: :created
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  # Updates schedules either fully or partially.
  ## PUT/PATCH  /rooms/:room_id/meetings/:meeting_id/schedules/:id
  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  # Removes schedules.
  ## DELETE  /rooms/:room_id/meetings/:meeting_id/schedules
  def destroy
    @schedule.destroy
  end

  private

  # Set schedule instance variable @schedule.
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Permits the parameters for schedule.
  def schedule_params
    params.require(:schedule).permit(:title, :date, :start_time, :end_time)
  end
end
