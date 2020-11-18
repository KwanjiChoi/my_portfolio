class StaticPagesController < ApplicationController
  before_action :sign_in_user

  def home
    @recent_projects = Project.recent_projects.includes([:user, :rich_text_content])
  end

  private

  def sign_in_user
    redirect_to dashboard_path if current_user.present?
  end
end
