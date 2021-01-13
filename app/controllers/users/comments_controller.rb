class Users::CommentsController < CommentsController
  before_action :set_commentable
  before_action :correct_commenter

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

  def correct_commenter
    redirect_to user_path(@commentable) if current_user == @commentable
  end

  def set_commentable
    @commentable = User.find(params[:user_id])
  end
end
