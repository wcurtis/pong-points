class Game < ActiveRecord::Base
  has_and_belongs_to_many :players

  after_update do |game|
    
    if game.status == 'finished' && game.winner

      # Send game win event to Sweet Tooth to earn points
      event = SweetTooth::Event.create(
        "customer_id"  => Player.find(game.winner).st_id,
        "event_type"   => "game_win"
      )
      puts "Sent event to ST: " + event.id;
    end
  end
end
