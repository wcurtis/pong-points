class Game < ActiveRecord::Base
  has_and_belongs_to_many :players

  after_update do |game|

    if game.status == 'finished' && game.winner

      # Send game win activity to Sweet Tooth to earn points
      event = SweetTooth::Activity.create(
        "customer_id"  => Player.find(game.winner).st_id,
        "verb"   => "game_win"
      )
      puts "Sent activity to ST: " + event.id;
    end
  end
end
