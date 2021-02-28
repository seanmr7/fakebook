# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create!(email: "test1@test.com", password: "123456", password_confirmation: "123456", first_name: "Johnny", last_name: "Butt")
user2 = User.create!(email: "test2@test.com", password: "123456", password_confirmation: "123456", first_name: "Jimmy", last_name: "Pants")