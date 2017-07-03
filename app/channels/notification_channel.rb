# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NotificationChannel < ApplicationCable::Channel
  def subscribed
      channel_name = "#{current_user.email}_notification_channel"
      stream_from channel_name
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
    if data["action_type"] == "read_all_notification"
      current_user.passive_notifications.each do |notification|
        notification.read = true
        notification.save
      end
    end
  end
end
