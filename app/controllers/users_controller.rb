class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:projects]
  before_action :authenticate_nonteacher, only: [:apply_teacher, :activate_teacher]
  before_action :unconfirmed?, only: :activate_teacher
  before_action :correct_user, only: [:edit, :update]

  def index; end

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    @checked_active_reservations = Reservation.sort_reservations_by_status(
      current_user, requester: true, status: 'checked'
    )
  end

  def apply_teacher; end

  def activate_teacher
    user = User.find(params[:id])
    if user == current_user
      ActivateMailer.apply_teacher_account(user).deliver_now
      ActivateTeacherJob.set(wait: 30.seconds).perform_later user
      user.create_performance
      flash[:notice] = 'teacher accountの申請を受け付けました、メールをご確認ください'
      redirect_to root_path, status: 200
    else
      redirect_to root_path
    end
  end

  def projects
    @user = User.find(params[:id])
    @projects = @user.projects.includes(:rich_text_content)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'User情報を更新しました'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :image, :phone_number, :introduction)
  end

  def authenticate_nonteacher
    redirect_to root_path if current_user.teacher?
  end

  def unconfirmed?
    redirect_to root_path if current_user.unconfirmed_email.present?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end
end
