# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# require 'faker'

User.create!(first_name:"Sarah", last_name: "Ing", email:"chocolate@gmail.com", password:"chocolate", street_address: "351 West Hubbard Street", city: "Chicago", state: "IL", zip: 60654, max_distance: 2)

# Added sleep 1 to keep Google happy
30.times do
  User.create!(first_name: Faker::Name.name, last_name: Faker::Name.name, email: Faker::Internet.email, password: "password", bio: "just want to learn", preferred_language: "english", street_address: Faker::Address.street_address, city: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

users = User.all

10.times do
  Course.create!(name: Faker::Company.name, organization: Faker::Company.name, description: Faker::Commerce.product_name)
end

courses = Course.all


150.times do 
  Question.create!(title: Faker::Hacker.say_something_smart, content: Faker::Hacker.say_something_smart, user: users.sample, course: courses.sample)
end

questions = Question.all

75.times do
  Response.create!(content: Faker::Lorem.paragraph, user: users.sample, question: questions.sample )
end

responses = Response.all

# response = HTTParty.get("https://data.cityofchicago.org/resource/wa2i-tm5d.json")
# p venues = JSON.parse(response.body)

venues_array = SmarterCSV.process('db/Libraries.csv', row_sep: "\r")

venues_array.each do |venue|
  Venue.create!(venue)
end



50.times do
  venue = Venue.find(rand(Venue.count)+1)
  Meetup.create!(course: courses.sample, organizer: users.sample, venue: venue, remote: true, latitude: venue.latitude, longitude: venue.longitude)
end

meetups = Meetup.all

50.times do
  CourseMembership.create!(course_id: courses.sample.id, user_id: users.sample.id)
end

50.times do
  MeetupMembership.create!(meetup_id: meetups.sample.id, user_id: users.sample.id)
end

ka = Provider.create!(name: "khan_academy",
                      site: "http://www.khanacademy.org/api/v1",
                      key: "UHze9rM6n5NtNee2",
                      secret: "f9Z24DkmGTyWZx5E")

users.each do |user|
  number = rand(1000..9999).to_s
  Authorization.create!(provider: Provider.find(ka.id),
                        uid: "uidstring" + number,
                        user: user,
                        user_token: "user_token" + number,
                        user_secret: "user_secret" + number)
end
