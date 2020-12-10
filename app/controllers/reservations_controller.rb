class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_requester, only: [:show_active]
  before_action :correct_supplier,  only: [:show_passive]
  before_action :correct_user, only: [:teacher_index]
  before_action :correct_user_reservation, only: [:create]
  before_action :authenticate_only_requester_and_supplier, only: [:edit, :update, :destroy]
  before_action :authenticate_teacher_account!, only: [:teacher_index]

  # define helper methods

  STATUS = Reservation.statuses.keys.freeze # ['unchecked', 'checked', 'finished', 'canceled']

  STATUS.each do |status|
    method_name = "#{status}_active_reservations"
    define_method method_name do |user|
      Reservation.sort_reservations_by_status(user, requester: true, status: status)
    end
    helper_method method_name.to_sym
  end

  STATUS.each do |status|
    method_name = "#{status}_passive_reservations"
    define_method method_name do |user|
      Reservation.sort_reservations_by_status(user, supplier: true, status: status)
    end
    helper_method method_name.to_sym
  end

  def reservation
    return nil if params[:id].blank?
    @reservation ||= Reservation.find(params[:id])
  end

  def requester
    @requester ||= reservation&.requester
  end

  def supplier
    @supplier ||= reservation.supplier
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def new_reservation
    @new_reservation ||= Reservation.new
  end

  def message_room
    @message_room ||= Room.find_by(reservation: reservation)
  end

  helper_method :reservation, :requester, :supplier,
                :project, :new_reservation, :message_room

  # get actions

  def new;           end

  def index;         end

  def show_active;   end

  def show_passive;  end

  def edit;          end

  def teacher_index; end

  # post put delete actions

  def create
    reservation = project.passive_reservations.build(reservation_params)
    if reservation.save
      reservation.create_chat_room
      redirect_to active_reservation_path(current_user, reservation), notice: '予約が完了いたしました'
    else
      render :new, locals: { new_reservation: reservation }
    end
  end

  def destroy
  end

  def update
    if reservation.update(reservation_params)
      if reservation.requester == current_user
        redirect_to active_reservation_path(current_user, reservation)
      elsif reservation.supplier == current_user
        redirect_to passive_reservation_path(project, reservation)
      end
    else
      render :edit, locals: { new_reservation: reservation }
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_at,
                                        :reserve_time,
                                        :address,
                                        :requester_id,
                                        :request_text)
  end

  def correct_user
    redirect_to root_path unless current_user == User.find(params[:id])
  end

  def correct_user_reservation
    redirect_to root_path unless current_user.id == params[:reservation][:requester_id].to_i
    redirect_to root_path if project.user == current_user
  end

  def correct_requester
    redirect_to root_path unless reservation.requester == current_user
  end

  def correct_supplier
    redirect_to root_path unless reservation.supplier  == current_user
  end

  def authenticate_only_requester_and_supplier
    if reservation.requester != current_user && reservation.supplier != current_user
      redirect_to root_path
    end
  end
end
