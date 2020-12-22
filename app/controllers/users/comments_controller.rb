class Users::CommentsController < CommentsController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.commenter = current_user
    @user = @commentable
    if @comment.save
        redirect_to @commentable, notice: 'Your comment was successfully posted!'
    else
      render 'users/show'
    end
  end
  private

  def set_commentable
    @commentable = User.find(params[:user_id])
  end

end