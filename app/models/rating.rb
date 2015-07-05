class Rating < ActiveRecord::Base
  validates :rating, :rateable_id, :rateable_type, :rater_id, presence: true
  validates_uniqueness_of :rater_id, :scope => [:rateable_id, :rateable_type]

  after_commit :set_notification, on: [:create, :update]

  belongs_to :rateable, polymorphic: true

  belongs_to(
    :rater,
    class_name: "User",
    foreign_key: :rater_id,
    primary_key: :id,
    inverse_of: :rated_objects
  )

  has_many :notifications, as: :notifiable, dependent: :destroy

  def set_notification
    if self.rateable.class == User && rater != rateable
      notification = notifications.unread.event(:rated_you).new
      notification.user_id = rateable.id
      notification.save!
    end

    self.rateable.followers.each do |user|
      next if user == self.rater
      notification = user.notifications.unread.event(:rated).new
      notification.notifiable_id = self.id
      notification.notifiable_type = "Rating"
      notification.save!
    end
  end
end
