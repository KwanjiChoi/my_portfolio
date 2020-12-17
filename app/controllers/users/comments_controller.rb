class Users::CommentsController < CommentsController
  def create
    user = User.find(params[:user_id])
    user.comment.create(user_comment_params)
    redirect_to user_path(user), notice: 'コメントを投稿しました'
  end

  private

  def user_comment_params
    params.require(:comment).permit(:comment, :commenter_id)
  end

end