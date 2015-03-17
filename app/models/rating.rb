class Rating < ActiveRecord::Base
  validates :rating, :rateable_id, :rateable_type, :rater_id, presence: true
  validates_uniqueness_of :rater_id, :scope => [:rateable_id, :rateable_type]

  belongs_to :rateable, polymorphic: true

  belongs_to(
    :rater,
    class_name: "User",
    foreign_key: :rater_id,
    primary_key: :id,
    inverse_of: :rated_objects
  )
end
