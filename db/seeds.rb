require 'faker'
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

puts "Creating user !"

new_user = User.new
new_user.email = "admin@mail.com"
new_user.password = "azerty"
new_user.first_name = "Bob"
new_user.last_name = "l'Eponge"
new_user.save!

puts "Admin user create"
puts "Creating Unicorns"


40.times do
  unicorn = Unicorn.new(location: Faker::Address.full_address, name: Faker::Name.name, price: rand(5..999), description: Faker::Fantasy::Tolkien.poem, user: User.first, image_url: "https://media.istockphoto.com/id/1165132299/fr/vectoriel/licorne-autocollant-amusant-autocollant-damusement-color%C3%A9-licorne-de-t%C3%AAte.jpg?s=612x612&w=0&k=20&c=Pth_rdH7NbJaPSSvwloTdpDSr7vhKQkK9X59mDEuv1w=")
  unicorn.save!
end

puts "Unicorn created !"
