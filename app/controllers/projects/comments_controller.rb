class Projects::CommentsController < CommentsController
  def create
    project = Project.find(params[:project_id])
    projecr.comments.create(project_comment_params)
    redirect_to project_path(project), notice: 'コメントを投稿しました'
  end

  private

  def project_comment_params
    params.require(:comment).permit(:comment, :commenter_id)
  end
end