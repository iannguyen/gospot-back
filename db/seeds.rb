# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! email: 'ian@ian.com', password: 'lalalala'
User.create! email: 'don@don.com', password: 'lalalala'
User.create! email: 'tracie@tracie.com', password: 'lalalala'
User.create! email: 'kevin@kevin.com', password: 'lalalala'
User.create! email: 'jordan@jordan.com', password: 'lalalala'
User.create! email: 'bo@bo.com', password: 'lalalala'
User.create! email: 'blaka@blaka.com', password: 'lalalala'
User.create! email: 'device@device.com', password: 'lalalala'

User.create! email: 'alvin@alvin.com', password: 'lalalala'
User.create! email: 'austin@austin.com', password: 'lalalala'
User.create! email: 'andrew@andrew.com', password: 'lalalala'
User.create! email: 'edmund@edmund.com', password: 'lalalala'
User.create! email: 'david@david.com', password: 'lalalala'
User.create! email: 'me@me.com', password: 'lalalala'
User.create! email: 'bane@bane.com', password: 'lalalala'
User.create! email: 'friberg@friberg.com', password: 'lalalala'

User.create! email: 'guest1@gospot.com', password: 'lalalala'
User.create! email: 'guest2@gospot.com', password: 'lalalala'
User.create! email: 'guest3@gospot.com', password: 'lalalala'
User.create! email: 'guest4@gospot.com', password: 'lalalala'
User.create! email: 'guest5@gospot.com', password: 'lalalala'
User.create! email: 'guest6@gospot.com', password: 'lalalala'
User.create! email: 'guest7@gospot.com', password: 'lalalala'
User.create! email: 'guest8@gospot.com', password: 'lalalala'
User.create! email: 'guest9@gospot.com', password: 'lalalala'
User.create! email: 'guest10@gospot.com', password: 'lalalala'

Team.create! name: "WOW_WE_LAGGED"
Team.create! name: "php_poets"
Team.create! name: "Ruby_Rushers"
Team.create! name: "da_pythons"

Match.create! team_1_id: 1, team_2_id: 2, location: "de_dust2", start_hour: 20
Match.create! team_1_id: 3, team_2_id: 4, location: "de_inferno", start_hour: 16
