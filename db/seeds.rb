# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

user1 = User.create!(email: "example1@test.com", password: Rails.application.credentials.default_user[:password], password_confirmation: Rails.application.credentials.default_user[:password], first_name: "Johnny", last_name: "Butt")
user2 = User.create!(email: "example2@test.com", password: Rails.application.credentials.default_user[:password], password_confirmation: Rails.application.credentials.default_user[:password], first_name: "Jimmy", last_name: "Pants")

# Create users
15.times do |i|
  password = Faker::Alphanumeric.alphanumeric(number: 12)
  User.create!(email: "test#{i}@test.com", password: password, password_confirmation: password, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
end

User.all.each do |user|
  # Generate 3 to 10 posts for each user
  Faker::Number.between(from: 3, to: 10).times do
    Post.create!(content: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 3, to: 10)), user_id: user.id)
  end

  # Create friendships between seeded users
  User.all.each do |user2|
    next if user == user2
    Friendship.create!(sent_by_id: user.id, sent_to_id: user2.id, status: true)
  end
end

Post.all.each do |post|
  # Like each post between 0 and 15 times
  Faker::Number.between(from: 0, to: 15).times do |i|
    Like.create!(user_id: i+1, post_id: post.id)
  end

  # Generate between 0 and 5 comments for each post
  Faker::Number.between(from: 0, to: 5).times do
    Comment.create!(comment: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 5)), post_id: post.id, user_id: Faker::Number.between(from: 1, to: 17))
  end
end