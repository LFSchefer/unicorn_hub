# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning"
Unicorn.destroy_all
User.destroy_all

new_user = User.new
new_user.email = "admin@mail.com"
new_user.password = "azerty"
new_user.save!


puts "Admin user create"
