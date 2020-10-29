class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_nonteacher, only: [:apply_teacher, :activate_teacher]

  def index
  end

  def show
    @user = current_user
  end

  def dashboard
  end

  def apply_teacher;end

  def activate_teacher
    user = User.find(params[:id])
    if user == current_user
      current_user.activate_teacher
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
end
