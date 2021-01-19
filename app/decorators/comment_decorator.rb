class CommentDecorator < Draper::Decorator
  delegate_all

  def created_at
    created_at.strftime('%m月%d日')
  end
end
