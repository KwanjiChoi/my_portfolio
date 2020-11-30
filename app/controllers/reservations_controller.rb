class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create]
  before_action :correct_requester, only: [:show_active]

  def index; end

  def show_active; end

  def show_passive; end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @project.passive_reservations.build(reservation_params)
    if @reservation.save
      redirect_to user_reservations_path(current_user), notice: '予約が完了いたました'
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

  # メタプログラミングっぽく

  def reservation
    @reservation ||= Reservation.find(params[:id])
  end

  def requester
    @requester ||= reservation.requester
  end

  def supplier
    @supplier ||= reservation.supplier
  end

  helper_method :reservation, :requester, :supplier

  STATUS = Reservation.statuses.keys.freeze

  STATUS.each do |status|
    method_name = "#{status}_active_reservations"
    define_method method_name do |user|
      Reservation.sort_reservations_by_status(user, requester: true, status: status)
    end
    helper_method method_name.to_sym
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_at, :reserve_time, :requester_id, :request_text)
  end

  def correct_requester
    redirect_to root_path unless reservation.requester == current_user
  end

  def correct_supplier
  end
end
