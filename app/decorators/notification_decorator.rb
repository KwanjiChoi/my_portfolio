class NotificationDecorator < ApplicationDecorator
  delegate_all
  include ActionView::Helpers::DateHelper

  def visitor_name
    object.visitor.username
  end

  def created_at
    time_ago_in_words(object.created_at)
  end

  def project_title
    object.notificatable.project.title
  end

  def commentable_project_title
    object.notificatable.commentable.title
  end
end
