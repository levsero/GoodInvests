FactoryGirl.define do
  factory :user, aliases: [:rater] do
    first_name "lev"
    last_name  "ser"
    password "testing"
    email Faker::Internet.email
  end
end
