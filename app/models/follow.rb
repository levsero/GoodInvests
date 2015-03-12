class Follow < ActiveRecord::Base
  validates :followable_id, :followable_type, :follower_id, presence: true

  belongs_to :followable, polymorphic: true

  belongs_to(
    :follower,
    class_name: "User",
    foreign_key: :follower_id,
    primary_key: :id,
    inverse_of: :follows
  )
end
