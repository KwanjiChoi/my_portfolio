class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_teacher_account!

  def index
    @projects = current_user.projects.includes([:rich_text_content])
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
    project = Project.find(params[:id])
    if project.destroy
      redirect_to projects_path, notice: 'deleted successfully'
    else
      render :show
    end
  end

  private

  def project_params
    params.require(:project).permit(:title,
                                    :content,
                                    :main_image,
                                    :project_category_id,
                                    :phone_reservation)
  end

  def correct_user
    project = Project.find(params[:id])
    redirect_to dashboard_path unless project.user == current_user
  end
end
