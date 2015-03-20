class Comment < ActiveRecord::Base
  validates :body, :title, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true

  after_commit :set_notification, on: [:create]

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :authored_comments
  )

  has_many :notifications, as: :notifiable, dependent: :destroy

  def set_notification
    event_name = self.commentable.class == User ? :comment_on_user : :comment_on_company

    if event_name == :comment_on_you
      notification = commentable.notifications.unread.event(event_name).new
      notification.notifiable_id = self.id
      notification.notifiable_type = "Comment"
      notification.save!
    end

    self.commentable.followers.each do |user|
      event_name = :commented_on_you if user == self.commentable
      next if user == self.author
      notification = user.notifications.unread.event(event_name).new
      notification.notifiable_id = self.id
      notification.notifiable_type = "Comment"
      notification.save!
    end
  end
end
