class Notification < ActiveRecord::Base
  EVENTS = {
    1 => :comment_on_user,
    2 => :comment_on_company,
    3 => :user_followed_company,
    4 => :user_commented_on_comapany,
    5 => :commented_on_you,
    6 => :rated,
    7 => :rated_you
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
        author = notifiable.author
        comment_user = notifiable.commentable
        "#{author.name} commented on #{comment_user.name}\'s profile"
      when :comment_on_company
        author = notifiable.author
        company = notifiable.commentable
        "#{author.name} commented on #{company.name}"
      when :commented_on_you
        author = notifiable.author
        "#{author.name} commented on your profile"
      when :rated
        rater = notifiable.rater
        reated = notifiable.rateable
        "#{rater.name} rated #{rated} #{notifiable.rating} stars"
      when :rated_you
        rater = notifiable.rater
        "#{rater.name} gave you a #{notifiable.rating} stars rating"
    end
  end

  def event_name
    EVENTS[self.event_id]
  end
end
