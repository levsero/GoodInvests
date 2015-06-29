FactoryGirl.define do
  factory :rating do
    # rater
    rateable_id "1"
    rateable_type "User"
    rater_id "54"
    rating 3
  end
end
