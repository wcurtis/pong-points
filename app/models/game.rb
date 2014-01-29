class Game < ActiveRecord::Base

  has_and_belongs_to_many :players

  before_create :redeemGamePlay

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

  after_initialize do |game|

    # Only fetch for points earned on this activity if the activity
    # has been send to Sweet Tooth and the points value is not already cached
    if game.st_activity_id && (game.st_points_change == nil)
      activity = SweetTooth::Activity.retrieve(game.st_activity_id)

      # Poll Sweet Tooth until the activity is finished processing
      while !activity.processed
        puts "Waiting on activity processing 500 ms"
        sleep 1
        activity = SweetTooth::Activity.retrieve(game.st_activity_id)
      end

      puts activity.inspect

      game.st_points_change = activity.points_change
      game.save!
    end
  end


  private
    def redeemGamePlay
      redemptions = []

      # Spend points on game play
      # TODO: Catch errors if a player has insufficient funds
      self.players.each do |player|
        redemption = SweetTooth::Spending.create(
          :customer_id => player.st_id,
          :spending_option_id => 'game_play'
        )
        redemptions.push(redemption.id)
      end

      self.st_redemption_ids = redemptions.join(",")

      puts "Spending created: " + redemptions.join(",")
    end
end
