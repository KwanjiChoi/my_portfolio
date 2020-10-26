class StaticPagesController < ApplicationController
  before_action :sign_in_user

  def home
  end

  private

  def sign_in_user
    redirect_to dashboard_path if current_user.present?
  end
end
