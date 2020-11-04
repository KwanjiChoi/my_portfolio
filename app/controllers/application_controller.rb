class ApplicationController < ActionController::Base
  def authenticate_teacher_account!
    redirect_to root_path if !current_user.teacher?
  end
end
