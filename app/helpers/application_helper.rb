module ApplicationHelper
  def page_title(title: '')
    if title.blank?
      Constants::BASE_TITLE
    else
      "#{title} - #{Constants::BASE_TITLE}"
    end
  end
end
