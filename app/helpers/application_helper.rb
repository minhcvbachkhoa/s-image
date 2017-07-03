module ApplicationHelper
  def full_title title
    title.empty? ? t("social-image") : title + " | " + t("social-image")
  end

  Settings.objs.each do |obj|
    Settings.attrs.each do |attr|
      define_method("#{attr}_#{obj}") do |object|
        if object.present? && object.send(attr).present?
          object.send(attr)
        else
          "#{attr}_#{obj}.jpg"
        end
      end
    end
  end

  def convert_notification notification
    owner = notification.owner
    recipient = notification.recipient
    group = notification.group
    if owner == recipient
      "#{owner.name} want to join group #{group.name}"
    else
      "#{owner.name} has invited you to join to group #{group.name}"
    end
  end
end
