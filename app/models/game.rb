class Game < ActiveRecord::Base
  has_and_belongs_to_many :players

  after_update do |game|

    if game.status == 'finished' && game.winner && game.st_activity_id == nil

      # Send game win activity to Sweet Tooth to earn points
      activity = SweetTooth::Activity.create(
        "customer_id"  => Player.find(game.winner).st_id,
        "verb"   => "game_win"
      )
      puts "Sent activity to ST: " + activity.id;

      game.st_activity_id = activity.id;
      game.save!
    end
  end
end
