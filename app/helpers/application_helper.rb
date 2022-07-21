module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".base_title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
  # Returns the Gravatar for the given user.
end
