class Projects::CommentsController < CommentsController
  before_action :set_commentable
  before_action :correct_commenter

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.commenter = current_user
    if @comment.save
      @comment.create_notification
      redirect_to detail_project_path(@commentable), notice: 'Your comment was successfully posted!'
    else
      render 'projects/detail'
    end
  end

  private

  def correct_commenter
    redirect_to detail_project_path(@commentable) if current_user == @commentable.user
  end

  def set_commentable
    @commentable = Project.find(params[:project_id])
  end
end
