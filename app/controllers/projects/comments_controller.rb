class Projects::CommentsController < CommentsController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.commenter = current_user
    @project = @commentable
    if @comment.save
      redirect_to detail_project_path(@commentable), notice: 'Your comment was successfully posted!'
    else
      render 'projects/detail'
    end
  end

  private

  def set_commentable
    @commentable = Project.find(params[:project_id])
  end

end