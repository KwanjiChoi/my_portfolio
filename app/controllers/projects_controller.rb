class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
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

  private
  def project_params
    params.require(:project).permit(:title, :text, :content)
  end
end
