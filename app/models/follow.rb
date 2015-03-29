class Follow < ActiveRecord::Base
  validates :followable_id, :followable_type, :follower_id, presence: true
  validates_uniqueness_of :follower_id, :scope => [:followable_id, :followable_type]

  belongs_to :followable, polymorphic: true

  belongs_to(
    :follower,
    class_name: "User",
    foreign_key: :follower_id,
    primary_key: :id,
    inverse_of: :followings
  )
end
