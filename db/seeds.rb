# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Company.delete_all

User.create!({email: "testing@gmail.com", first_name: "lev", last_name: "ser",
  password: "password"})
User.create!({email: "example@gmail.com", first_name: "Warren", last_name: "Buffet",
  job_title: "Chief Executive Officer", description: "A proven record in buying solid shares",
  password: "password"})
User.create!({email: "testing@gmail.com", first_name: "google", last_name: "fox",
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
  body: "looks like a solid portfolio you have over there", commentable_id: User.last,
  commentable_type: "User"})

User.second.authored_comments.create({title: "fair'd inkum",
  body: "no doubt he's the real mccoy", commentable_id: User.first,
  commentable_type: "User"})
