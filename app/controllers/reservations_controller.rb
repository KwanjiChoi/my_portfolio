class ReservationsController < ApplicationController
  include DefineMethod::ReservationMethods
 
  before_action :define_helper_methods
  before_action :authenticate_user!
  before_action :correct_requester, only: [:show_active]
  before_action :correct_supplier,  only: [:show_passive, :confirm]
  before_action :correct_user, only: [:teacher_index]
  before_action :correct_user_reservation, only: [:create]
  before_action :authenticate_only_requester_and_supplier, only: [:edit, :update, :destroy]
  before_action :authenticate_teacher_account!, only: [:teacher_index]

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
      if current_user == requester
        redirect_to active_reservation_path(current_user, reservation)
      else
        redirect_to passive_reservation_path(project, reservation)
      end
    else
      render :edit, locals: { new_reservation: reservation }
    end
  end

  def confirm
    reservation.update_status('checked')
    redirect_to passive_reservation_path(project, reservation), notice: '承認いたしました'
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
    redirect_to root_path unless requester == current_user
  end

  def correct_supplier
    redirect_to root_path unless supplier  == current_user
  end

  def authenticate_only_requester_and_supplier
    if requester != current_user && supplier != current_user
      redirect_to root_path
    end
  end
end
