require 'faker'
require "nokogiri"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Cleaning"
Review.destroy_all
Tag.destroy_all
Unicorn.destroy_all
User.destroy_all

puts "Creating admin !"

new_user = User.new
new_user.email = "admin@mail.com"
new_user.password = "azerty"
new_user.first_name = "Bob"
new_user.last_name = "l'Eponge"
new_user.save!

puts "Creating users !"
15.times do
  new_user = User.new(email: "#{Faker::Name.middle_name}@mail.com", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "azerty" )
  new_user.save!
  puts new_user
end

puts "Admin user create"
puts "Creating Tags !"

["small","pink","beautiful","exclusive","lovefull","friendly","cute","glittery","majestic","fabulous"].each do |tag|
  Tag.create!(name: tag)
end

puts "Tags create"
puts "Creating Unicorns"

50.times do
  unicorn = Unicorn.new(name: Faker::Name.name, price: rand(5..999), description: Faker::Fantasy::Tolkien.poem, user: User.first, image_url: "https://media.istockphoto.com/id/1165132299/fr/vectoriel/licorne-autocollant-amusant-autocollant-damusement-color%C3%A9-licorne-de-t%C3%AAte.jpg?s=612x612&w=0&k=20&c=Pth_rdH7NbJaPSSvwloTdpDSr7vhKQkK9X59mDEuv1w=")

  url = "https://www.bestrandoms.com/random-address-in-fr?quantity=1"
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML.parse(html_file)
  out = ""
  address = []

  html_doc.search(".content").each do |element|
    out = element.text.strip
    address = out.split(" ")
    address = address.slice(3,4)
    address = address.join(" ")
    address = address.gsub("FranceStreet:  ", "")
    address = address.gsub("City:", ",")
    address = address.gsub("State/province/area:", "")
  end

  sleep 0.5

  unicorn.address = address

  unicorn.save!
  rand(0..5).times do
    unicorn_tags = UnicornTag.new
    unicorn_tags.unicorn = unicorn
    unicorn_tags.tag = Tag.find(rand(Tag.first.id..Tag.last.id))
    unicorn_tags.save
  end
  rand(0..6).times do
    review = Review.new
    review.unicorn = unicorn
    review.user = User.find(rand(User.first.id..User.last.id))
    review.rating = rand(1..5)
    review.content = Faker::GreekPhilosophers.quote
    review.save!

    puts review
  end

  if unicorn.latitude == nil
    Unicorn.destroy(unicorn.id)
  end

  puts unicorn
end

puts "Unicorn created !"
puts "DONE !"
