# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! email: 'ian@ian.com', password: 'password'
User.create! email: 'don@don.com', password: 'password'
User.create! email: 'tracie@tracie.com', password: 'password'
User.create! email: 'test@test.com', password: 'password'
User.create! email: 'bo@bo.com', password: 'password'

Team.create! name: "WOW_WE_LAGGED"
Team.create! name: "php_poets"

Match.create! team_1_id: 1, team_2_id: 2, location: "de_dust2", open: true, start_hour: 20, team_1_score: 0

Skin.create! name: "AK-47: Elite Build", price: 0.77, user_id: 1
Skin.create! name: "USP-S: Guardian", price: 1.23, user_id: 1
Skin.create! name: "M4A4: Desert Strike", price: 4.00, user_id: 1
Skin.create! name: "AWP: Worm God", price: 5.00, user_id: 1
Skin.create! name: "M4A1-S: Hyper Beast", price: 9.51, user_id: 1

# Bet Seeds

bet1 = Bet.new user_id: 1, match_id: 1, team_id: 1
bet1.skins = [
Skin.create!(name: "AK-47: Elite Build", price: 0.77, user_id: 1, bet_id: nil),
Skin.create!(name: "M4A1-S: Hyper Beast", price: 9.51, user_id: 1),
Skin.create!(name: "Karambit: Marble Fade", price: 500.00, user_id: 1),
]
bet1.save!

bet2 = Bet.new user_id: 2, match_id: 1, team_id: 1
bet2.skins = [
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 2, bet_id: 2),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 2, bet_id: 2),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 2, bet_id: 2),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 2, bet_id: 2),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 2, bet_id: 2),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 2, bet_id: 2),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 2, bet_id: 2)
]
bet2.save!

bet3 = Bet.new user_id: 3, match_id: 1, team_id: 2
bet3.skins = [
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 3, bet_id: 3),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 3, bet_id: 3),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 3, bet_id: 3),
Skin.create!( name: "AWP: Worm God", price: 5.00, user_id: 3, bet_id: 3),
Skin.create!(name: "M4A1-S: Hyper Beast", price: 9.51, user_id: 3, bet_id: 3),
Skin.create!(name: "M4A1-S: Hyper Beast", price: 9.51, user_id: 3, bet_id: 3),
Skin.create!(name: "M4A1-S: Hyper Beast", price: 9.51, user_id: 3, bet_id: 3),
Skin.create!(name: "M4A1-S: Hyper Beast", price: 9.51, user_id: 3, bet_id: 3),
]
bet3.save!
