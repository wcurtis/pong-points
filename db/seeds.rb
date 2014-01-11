# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

players = Player.create([
  { first_name: 'Wayne', last_name: "Rooney", profile_image_url: "/assets/players/rooney.jpg" },
  { first_name: 'Leonel', last_name: "Messi", profile_image_url: "/assets/players/messi.jpg" }
])

# Crate a finished game
game = Game.new({ status: 'finished' })
game.players.push(players[0])
game.players.push(players[1])
game.winner = players[0].id
game.save

# Create an in progress game
game = Game.new({ status: 'in_progress' })
game.players.push(players[0])
game.players.push(players[1])
game.save

