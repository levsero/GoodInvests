FactoryGirl.define do
  factory :company do
    ticker Faker::Lorem.characters(3)
    name Faker::Name.name
    price Random.rand(100)
  end
end
