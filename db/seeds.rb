# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

players = Player.create([
  { first_name: 'Alex', last_name: "Willemsma", email: "awillemsma@sweettoothhq.com", profile_image_url: "/assets/players/alex.jpg" },
  { first_name: 'Bill', last_name: "Curtis", email: "wcurtis@sweettoothhq.com", profile_image_url: "/assets/players/bill.jpg" },
  { first_name: 'Carol', last_name: "Spira", email: "cspira@sweettoothhq.com", profile_image_url: "/assets/players/carol.jpg" },
  { first_name: 'Kyla', last_name: "Freund", email: "kfreund@sweettoothhq.com", profile_image_url: "/assets/players/kyla.jpg" },
  { first_name: 'Mike', last_name: "Rossi", email: "mrossi@sweettoothhq.com", profile_image_url: "/assets/players/mike.jpg" },
  { first_name: 'Mohsen', last_name: "Hadianfard", email: "mhadianfard@sweettoothhq.com", profile_image_url: "/assets/players/mohsen.jpg" },
  { first_name: 'Steve', last_name: "Deckert", email: "sdeckert@sweettoothhq.com", profile_image_url: "/assets/players/steve.jpg" },
  { first_name: 'Vlad', last_name: "Vanca", email: "vvanca@sweettoothhq.com", profile_image_url: "/assets/players/vlad.jpg" },
  { first_name: 'Walt', last_name: "Huber", email: "whuber@sweettoothhq.com", profile_image_url: "/assets/players/walt.jpg" },
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

