# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!({email: "testing@gmail.com", first_name: "lev", last_name: "ser",
  password: "password"})
User.create!({email: "example@gmail.com", first_name: "test", last_name: "testing",
  job_title: "Chief Executive Officer", description: "A proven record in buying solid share",
  password: "password"})
