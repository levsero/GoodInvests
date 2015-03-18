class Notification < ActiveRecord::Base
  EVENTS = {
    1 => :comment_on_user,
    2 => :comment_on_followed_company,
    # these require following other user
    3 => :user_followed_company,
    4 => :user_commented_on_comapany,
    # 5 => :user_commented_on_user
    6 => :user_rated_a_comapany,
    7 => :user_rated_a_user
  }

  # creates a hash with the keys and values inverted
  EVENT_IDS = EVENTS.invert

  belongs_to :user, inverse_of: :notifications, counter_cache: true
  belongs_to :notifiable, inverse_of: :notifications, polymorphic: true

  validates :event_id, inclusion: { in: EVENTS.keys }
  validates :is_read, inclusion: { in: [true, false] }
  validates :notifiable, :user, presence: true

  scope :read, -> { where(is_read: true) }
  scope :unread, -> { where(is_read: false) }
  scope :event, ->(event_name) { where(event_id: EVENT_IDS[event_name]) }

  def text
    case self.event_name
    when :comment_on_user
      comment = self.notifiable
      comment_user = comment.author

      if self.user == current_user
        "#{comment_user.name} commented on your profile"
      else
        "#{comment_user.name} commented on #{comment_user.name}\'s profile"
      end
    when :comment_on_followed_company
      comment = self.notifiable
      comment_user = comment.author
      company = comment.commentable

      "#{comment_user.name} commented on your #{company.name}"
    end
  end
end
