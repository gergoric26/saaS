# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'
include Faker

15.times do
  Wiki.create!(
                title: Book.title,
                body: Lorem.sentences
                #private: random_boolean = [true, false].sample
  )

puts Wiki.inspect
end

5.times do
   User.create!(
                 email:    Internet.email,
                 password: Internet.password,
                 role: rand(0..2)
   )

   puts Wiki.inspect
end

puts "#{User.count} users created"
puts "#{Wiki.count} wiki created"