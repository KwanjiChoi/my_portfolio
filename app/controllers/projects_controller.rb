class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:detail, :feed]
  before_action :correct_project_supplier, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_teacher_account!, except: [:detail, :feed]
  before_action :set_project, only: [:show, :destroy, :detail, :edit, :update]

  def index
    @projects = current_user.projects.includes(:rich_text_content)
  end

  def new
    @project = Project.new
    @project.build_location
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to project_path(@project), notice: 'created successfully'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Projectを更新しました'
    else
      render :edit
    end
  end

  def destroy
    project = Project.find(params[:id])
    if project.destroy
      redirect_to projects_path, notice: 'deleted successfully'
    else
      render :show
    end
  end

  def detail; end

  def feed
    @category = ProjectCategory.find(params[:category_id])
    if @category.present?
      @projects = Project.where(
        project_category_id: @category.id
      ).includes([:rich_text_content, :user])
    else
      @projects = Project.all.includes([:rich_text_content, :user])
    end
  end

  private

  def project_params
    params.require(:project).permit(:title,
                                    :content,
                                    :main_image,
                                    :project_category_id,
                                    :phone_reservation,
                                    location_attributes: [:prefecture_id, :id])
  end

  def correct_project_supplier
    project = Project.find(params[:id])
    redirect_to dashboard_path unless project.user == current_user
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
