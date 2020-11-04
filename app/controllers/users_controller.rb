class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_nonteacher, only: [:apply_teacher, :activate_teacher]
  before_action :unconfirmed?, only: :activate_teacher

  def index
  end

  def show
    @user = current_user
  end

  def dashboard
  end

  def apply_teacher; end

  def activate_teacher
    user = User.find(params[:id])
    if user == current_user
      current_user.activate_teacher
      ActivateMailer.send_activate_teacher_account(user).deliver
      flash[:notice] = 'activate your teacher account'
      redirect_to root_path, status: 200
    else
      redirect_to root_path
    end
  end

  private

  def authenticate_nonteacher
    redirect_to root_path if current_user.teacher?
  end

  def unconfirmed?
    redirect_to root_path if current_user.unconfirmed_email.present?
  end
end
