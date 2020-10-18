class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def new
  end

  def create
    @project = current_user.projects.build(project_params)
  end

  def show
  end

  def edit
  end

  def update

  end

  def destroy
  end

  def index
  end

  private
  def project_params
    params.require(:project).permit(:title, :text)
  end
end
