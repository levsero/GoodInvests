# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Company.delete_all
Comment.delete_all
Rating.delete_all
Follow.delete_all
Notification.delete_all

PgSearch::Document.delete_all

User.create!({email: "testing@gmail.com", first_name: "lev", last_name: "ser",
  job_title: "Senior Developer", description: "Whatever",
  password: "password"})
User.create!({email: "example@gmail.com", first_name: "Warren", last_name: "Buffet",
  job_title: "Chief Executive Officer", description: "A proven record in buying solid shares",
  password: "password"})
User.create!({email: "whatever@gmail.com", first_name: "google", last_name: "fox",
  job_title: "Senior Admin", description: "Code ninja",
  password: "password"})

File.foreach(Rails.root.to_s + "/db/companies/companies.txt") do |line|
  line = line.chomp
  sym = line.split(":")[0]
  name = line.split(":")[1]

  c = Company.new({name: name, ticker: sym})

  begin
    c.update_price
    c.save
  rescue
  end
end

User.first.authored_comments.create({title: "nah, yeh",
  body: "looks like a solid portfolio you have over there", commentable_id: User.last.id,
  commentable_type: "User"})

User.second.authored_comments.create({title: "fair'd inkum",
  body: "no doubt he's the real mccoy", commentable_id: User.first.id,
  commentable_type: "User"})

30.times do
  fname, lname = Faker::Name.name.split
  email = Faker::Internet.email
  description = Faker::Hacker.say_something_smart
  job = Faker::Lorem.sentence(2)
  password = Faker::Lorem.characters(10)
  picture = Faker::Avatar.image

  User.create!({email: email, first_name: fname, last_name: lname,
    job_title: job, description: description, password: password, picture: picture})

end

50.times do
  title = Faker::Lorem.sentence(3)
  body = Faker::Lorem.paragraph
  id =  User.all.sample.id
  random = User.all.sample.id
  type = "User"

  User.find(id).authored_comments.create({title: title, body: body,
    commentable_id: random, commentable_type: type})
end

50.times do
  title = Faker::Lorem.sentence(3)
  body = Faker::Lorem.paragraph
  id =  User.all.sample.id
  random = Company.all.sample.id
  type = "Company"

  User.find(id).authored_comments.create({title: title, body: body,
    commentable_id: random, commentable_type: type})
end

50.times do
  id =  User.all.sample.id
  rating = Random.rand(1..5)
  random = Company.all.sample.id
  type = "Company"

  User.find(id).rated_objects.create({rateable_id: random,
    rateable_type: type, rating: rating})
end

50.times do
  id =  User.all.sample.id
  rating = Random.rand(1..5)
  random = User.all.sample.id
  type = "User"

  User.find(id).rated_objects.create({rateable_id: random,
    rateable_type: type, rating: rating})
end

50.times do
  id =  User.all.sample.id
  random = Company.all.sample.id
  type = "Company"

  User.find(id).followings.create({followable_id: random, followable_type: type})
end
