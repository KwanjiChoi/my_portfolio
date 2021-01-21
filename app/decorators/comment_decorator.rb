class CommentDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime('%m月%d日')
  end

  def commenter_name
    object.commenter.username
  end

  def comment
    object.comment
  end
end
