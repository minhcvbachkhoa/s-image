module ApplicationHelper
  def full_title title
    title.empty? ? t("social-image") : title + " | " + t("social-image")
  end
end
