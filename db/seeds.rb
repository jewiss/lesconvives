# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

# Restaurant.where(name: 'Le Valois').destroy
# Restaurant.where(name: "L'Alicheur").destroy
# Restaurant.where(name: 'Tokugawa').destroy
# Restaurant.where(name: 'Los Amigos').destroy
# puts "4 seed initial restaurants destroyed"

Participant.destroy_all
Event.destroy_all
Address.destroy_all
User.destroy_all

puts "All addresses, users, events and participants destroyed !"

# Users
romain_pic = URI.open('https://avatars2.githubusercontent.com/u/57835214?s=460&v=4')
sandra_pic = URI.open('https://avatars0.githubusercontent.com/u/54173284?s=460&v=4')
eniko_pic = URI.open('https://avatars1.githubusercontent.com/u/57618412?s=460&v=4')
antoine_pic = URI.open('https://avatars3.githubusercontent.com/u/58262651?s=460&v=4')
germain_pic = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1497643579/b5yabm9mrg50xc4eyqt8.jpg')
thanh_pic = URI.open('https://avatars0.githubusercontent.com/u/25582652?s=460&v=4')
lucien_pic = URI.open('https://avatars3.githubusercontent.com/u/9754165?s=460&v=4')
sovana_pic = URI.open('https://avatars3.githubusercontent.com/u/57631438?s=460&v=4')
tim_pic = URI.open('https://avatars0.githubusercontent.com/u/59280703?s=460&v=4')
estelle_pic = URI.open('https://avatars3.githubusercontent.com/u/55833764?s=460&v=4')
renaud_pic = URI.open('https://avatars1.githubusercontent.com/u/17413076?s=460&v=4')
ambre_pic = URI.open('https://avatars2.githubusercontent.com/u/58850047?s=460&v=4')

romain = User.create!(first_name: 'Romain', last_name: 'Barbier', email: 'rb@sfr.fr', password: '123456')
romain.profile_picture.attach(io: romain_pic, filename: 'romain_pic.png', content_type: 'image/png')
sandra = User.create!(first_name: 'Sandra', last_name: 'Chatonnet', email: 'sc@sfr.fr', password: '123456')
sandra.profile_picture.attach(io: sandra_pic, filename: 'sandra_pic.png', content_type: 'image/png')
eniko = User.create!(first_name: 'Eniko', last_name: 'Guti', email: 'eg@sfr.fr', password: '123456')
eniko.profile_picture.attach(io: eniko_pic, filename: 'eniko_pic.png', content_type: 'image/png')
antoine = User.create!(first_name: 'Antoine', last_name: 'Desaché', email: 'ad@sfr.fr', password: '123456')
antoine.profile_picture.attach(io: antoine_pic, filename: 'antoine_pic.png', content_type: 'image/png')
germain = User.create!(first_name: 'Germain', last_name: 'Loret', email: 'gl@sfr.fr', password: '123456')
germain.profile_picture.attach(io: germain_pic, filename: 'germain_pic.png', content_type: 'image/png')
thanh = User.create!(first_name: 'Thanh', last_name: 'Tran', email: 'tt@sfr.fr', password: '123456')
thanh.profile_picture.attach(io: thanh_pic, filename: 'thanh_pic.png', content_type: 'image/png')
lucien = User.create!(first_name: 'Lucien', last_name: 'Magenta', email: 'lucienmagenta@sfr.fr', password: '123456')
lucien.profile_picture.attach(io: lucien_pic, filename: 'lucien_pic.png', content_type: 'image/png')
sovana = User.create!(first_name: 'Sovana', last_name: 'Romano', email: 'soro@sfr.fr', password: '123456')
sovana.profile_picture.attach(io: sovana_pic, filename: 'sovana_pic.png', content_type: 'image/png')
tim = User.create!(first_name: 'Tim', last_name: 'Regis', email: 'timreg@sfr.fr', password: '123456')
tim.profile_picture.attach(io: tim_pic, filename: 'tim_pic.png', content_type: 'image/png')
estelle = User.create!(first_name: 'estelle', last_name: 'Saget', email: 'estellesag@sfr.fr', password: '123456')
estelle.profile_picture.attach(io: estelle_pic, filename: 'estelle_pic.png', content_type: 'image/png')
renaud = User.create!(first_name: 'Renaud', last_name: 'Dor', email: 'renauddor@sfr.fr', password: '123456')
renaud.profile_picture.attach(io: renaud_pic, filename: 'renaud_pic.png', content_type: 'image/png')
ambre = User.create!(first_name: 'ambre', last_name: 'Mgt', email: 'ambremgt@sfr.fr', password: '123456')
ambre.profile_picture.attach(io: ambre_pic, filename: 'ambre_pic.png', content_type: 'image/png')
puts "12 users created"

# Restaurants
# levalois = Restaurant.create!(name: 'Le Valois', price_level: '2', rating: '4.3', food_category: 'French', address: '52 Rue de Douai, 75009 Paris, France', phone: '06 44 05 17 79', url: 'www.le-valois.fr')
# alicheur = Restaurant.create!(name: "L'Alicheur", price_level: '1', rating: '4.7', food_category: 'Chinese', address: '96 Rue Saint-Maur, 75011 Paris, France', phone: '01 43 38 61 38', url: 'www.lalicheur.com')
# tokugawa = Restaurant.create!(name: 'Tokugawa', price_level: '2', rating: '4.2', food_category: 'Japanese', address: '49 Boulevard du Montparnasse, 75006 Paris, France', phone: '01 42 22 32 59', url: 'tokugawa.fr')

losamigos_pic = URI.open('https://u.tfstatic.com/restaurant_photos/307/406307/169/612/los-amigos-vue-de-la-salle-e20a9.jpg')
losamigos = Restaurant.create!(name: 'Los Amigos', price_level: '3', rating: '4.5', food_category: 'Mexican', address: "23 Rue d'Enghien, 75010 Paris, France", phone: '01 45 89 80 21', url: 'losamigos.fr')
losamigos.photo.attach(io: losamigos_pic, filename: 'losamigos_pic.png', content_type: 'image/png')


puts "-------"
puts 'restaurant "Los Amigos" created'

# Addresses
romain_home = Address.create!(name: 'Home', full_address: '74 rue mazarine, 75006 Paris, France', user_id: romain.id, active: true)
romain_work = Address.create!(name: 'Work', full_address: '2 bis Avenue Foch, 75116 Paris, France', user_id: romain.id)
lucien_home = Address.create!(name: 'Home', full_address: '14 Rue Crespin du Gast, 75011 Paris, France', user_id: lucien.id, active: true)
lucien_work = Address.create!(name: 'Work', full_address: '35 Rue Sainte-Anne, 75001 Paris, France', user_id: lucien.id)
sovana_home = Address.create!(name: 'Home', full_address: '5 Rue Descartes, 75005 Paris, France', user_id: sovana.id, active: true)
sovana_home = Address.create!(name: 'Home', full_address: '1 Rue Clovis, 75005 Paris, France', user_id: sovana.id)
tim_home = Address.create!(name: 'Home', full_address: '2 Rue Lisfranc, 75020 Paris, France', user_id: tim.id, active: true)
tim_home = Address.create!(name: 'Home', full_address: '9 Rue Belgrand, 75020 Paris, France', user_id: tim.id)

sandra_work = Address.create!(name: 'Home', full_address: '3 rue oberkampf, 75011, Paris, France', user_id: sandra.id, active: true)
eniko_work = Address.create!(name: 'Home', full_address: '37 Quai Branly, 75007 Paris, France', user_id: eniko.id, active: true)
antoine_work = Address.create!(name: 'Home', full_address: '171 Rue de la Croix Nivert, 75015 Paris, France', user_id: antoine.id, active: true)
germain_work = Address.create!(name: 'Home', full_address: '3 rue des acacias, 75017, Paris, France', user_id: germain.id, active: true)
thanh_work = Address.create!(name: 'Home', full_address: '11 rue brillat-savarin, 75013, Paris, France', user_id: thanh.id, active: true)
renaud_work = Address.create!(name: 'Home', full_address: '10 rue Béranger, 75003, Paris, France', user_id: renaud.id, active: true)
ambre_work = Address.create!(name: 'Home', full_address: '15 rue René Boulanger, 75010, Paris, France', user_id: ambre.id, active: true)
estelle_work = Address.create!(name: 'Home', full_address: '26 rue Beautreillis, 75004, Paris, France', user_id: estelle.id, active: true)
puts 'addresses created'

# Events
d1 = Date.new(2020,02,24)
d2 = Date.new(2020,02,18)
d3 = Date.new(2020,02,13)

after_gaudelet = Event.create!(date: Date.new(2020,02,24), hour: Time.new(d1.year, d1.month, d1.day, 20, 00).asctime.in_time_zone("Paris"), name: 'Afterwork Gaudelet')
SelectedRestaurant.create(restaurant: losamigos, event: after_gaudelet)
lewagon_karaoke = Event.create!(date: Date.new(2020,02,18), hour: Time.new(d2.year, d2.month, d2.day, 21, 00).asctime.in_time_zone("Paris"), name: 'Dinner & Karaoke')
SelectedRestaurant.create(restaurant: losamigos, event: lewagon_karaoke)
friends_lunch = Event.create!(date: Date.new(2020,02,13), hour: Time.new(d3.year, d3.month, d3.day, 12, 30).asctime.in_time_zone("Paris"), name: 'Catch-up Lunch')
SelectedRestaurant.create(restaurant: losamigos, event: friends_lunch)

# lunch_dance = Event.create!(date: Date.parse('2020-02-03'), name: 'Lunch Dance Studio')
# dinner_family = Event.create!(date: Date.parse('2020-02-22'), name: 'Family Dinner')
# demo_day = Event.create!(date: Date.parse('2020-03-06'), name: 'Demo Day Gaudelet')
# tinder_date = Event.create!(date: Date.parse('2020-03-08'), name: 'Tinder Date')

puts "3 Events created"

# Participants
romain1 = Participant.create!(event_id: after_gaudelet.id, user_id: romain.id, owner: true, address_id: romain_work.id)
lucien1 = Participant.create!(event_id: after_gaudelet.id, user_id: lucien.id, owner: false, address_id: lucien_home.id)
puts "2 participants created for 'After Gaudelet'"

romain2 = Participant.create!(event_id: lewagon_karaoke.id, user_id: romain.id, owner: true, address_id: romain_work.id)
antoine1 = Participant.create!(event_id: lewagon_karaoke.id, user_id: antoine.id, owner: false, address_id: antoine_work.id)
thanh1 = Participant.create!(event_id: lewagon_karaoke.id, user_id: thanh.id, owner: false, address_id: thanh_work.id)
puts "3 participants created for 'Dinner & Karaoke'"

romain3 = Participant.create!(event_id: friends_lunch.id, user_id: romain.id, owner: true, address_id: romain_home.id)
sandra1 = Participant.create!(event_id: friends_lunch.id, user_id: sandra.id, owner: false, address_id: sandra_work.id)
eniko1 = Participant.create!(event_id: friends_lunch.id, user_id: eniko.id, owner: false, address_id: eniko_work.id)
germain1 = Participant.create!(event_id: friends_lunch.id, user_id: germain.id, owner: false, address_id: germain_work.id)
puts "4 participants created for 'Catch-up Lunch'"

puts '-------'
puts 'Seed finished'

