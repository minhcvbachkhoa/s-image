class NotificationJob < ApplicationJob
  queue_as :default

  def perform args
    ActionCable.server.broadcast args[:channel],
      {notification: args[:notification], owner: args[:owner],
      recipient: args[:recipient], group: args[:group]}
  end
end
