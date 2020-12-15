class ApplicationController < ActionController::Base
  include Lettable

  def authenticate_teacher_account!
    redirect_to root_path if !current_user.teacher?
  end

  def category_list
    @categolies ||= ProjectCategory.all
  end
  helper_method :category_list
end
