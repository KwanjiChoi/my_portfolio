class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to project_path(@project), notice: 'created successfully'
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def project_params
    params.require(:project).permit(:title, :content, :main_image)
  end

  def correct_user
    project = Project.find(params[:id])
    redirect_to dashboard_path unless project.user == current_user
  end
end
