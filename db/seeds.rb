# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Restaurant.destroy_all
Address.destroy_all
User.destroy_all
Event.destroy_all
Participant.destroy_all

# Users
romain = User.create!(first_name: 'Romain', last_name: 'Barbier', email: 'rb@sfr.fr', password: '123456')
lucien = User.create!(first_name: 'Lucien', last_name: 'Magenta', email: 'lucienmagenta@sfr.fr', password: '123456')

# Restaurants
levalois = Restaurant.create!(name: 'Le Valois', price_level: '2', rating: '4.3', food_category: 'French', address: '52 Rue de Douai, 75009 Paris, France', phone: '06 44 05 17 79', url: 'www.le-valois.fr')
alicheur = Restaurant.create!(name: "L'Alicheur", price_level: '1', rating: '4.7', food_category: 'Chinese', address: '96 Rue Saint-Maur, 75011 Paris, France', phone: '01 43 38 61 38', url: 'www.lalicheur.com')
tokugawa = Restaurant.create!(name: 'Tokugawa', price_level: '2', rating: '4.2', food_category: 'Japanese', address: '49 Boulevard du Montparnasse, 75006 Paris, France', phone: '01 42 22 32 59', url: 'tokugawa.fr')
losamigos = Restaurant.create!(name: 'Los Amigos', price_level: '3', rating: '4.5', food_category: 'Mexican', address: "23 Rue d'Enghien, 75010 Paris, France", phone: '01 45 89 80 21', url: 'losamigos.fr')

# Addresses
romain_home = Address.create!(name: 'Home', full_address: '74 rue mazarine, 75006 Paris, France', user_id: romain.id)
romain_work = Address.create!(name: 'Work', full_address: '2 bis Avenue Foch, 75116 Paris, France', user_id: romain.id)
lucien_home = Address.create!(name: 'Home', full_address: '14 Rue Crespin du Gast, 75011 Paris, France', user_id: lucien.id)
lucien_work = Address.create!(name: 'Work', full_address: '35 Rue Sainte-Anne, 75001 Paris, France', user_id: lucien.id)

# Events
dinner1 = Event.create!(date: Date.today, name: 'Diner des familles')

# Participants
romain1 = Participant.create!(event_id: dinner1.id, user_id: romain.id, owner: true, address_id: romain_home.id)
lucien1 = Participant.create!(event_id: dinner1.id, user_id: lucien.id, owner: false, address_id: lucien_home.id)


