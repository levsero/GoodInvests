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
    # self.commentable.
    notification = self.notifications.unread.event(:comment_on_user).new
    notification.user = self.author
    notification.save!
  end
end
