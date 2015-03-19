module Api
  class NotificationsController < ApplicationController
    before_action :require_signed_in!

    def update
      @notifcation = Notification.find(params[:id])

      if @notifcation.update({ is_read: true })
        render json: {notification: "was updated to true"}
      else
        render json: @notifcation.errors.full_messages, status: :unprocessable_entity
      end
    end

    def update_all
      current_user.notifications.unread.update_all(is_read: true)
      render json: {notifications: "gone"}
    end

    def index
      @notifications = current_user.notifications.unread
    end

    def owns_comment
      if !current_user.notifications.include(@notification)
        render json: "User does not match", status: 404
      end
    end

  end
end
