module ApplicationHelper
  def page_title(title: '')
    if title.blank?
      Constants::BASE_TITLE
    else
      "#{title} - #{Constants::BASE_TITLE}"
    end
  end

  def unconfirmed?(user)
    user.unconfirmed_email.present?
  end

  def new_comment
    Comment.new
  end

  def category_list
    ProjectCategory.all
  end
end
