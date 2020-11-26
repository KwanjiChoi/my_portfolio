class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @project.passive_reservations.build(reservation_params)
    if @reservation.save
    else
      render :new
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_at, :reserve_time, :requester_id, :request_text)
  end
end
