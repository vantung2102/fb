require "test_helper"

class NotificationRelayJobTest < ActiveJob::TestCase
  queue_as :default

  def perform(notification)
    html = ApplicationController.render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
  end
end
