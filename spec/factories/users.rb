# FactoryGirl.define do
#   sequence :email do |n|
#     "person#{n}@example.com"
#   end
# end

FactoryGirl.define do
  factory :user, aliases: [:rater] do
    first_name "lev"
    last_name  "ser"
    password "testing"
    sequence(:email, 100) { |n| "person#{n}@example.com" }
  end
end
