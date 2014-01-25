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

    if game.st_activity_id
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
      puts "REDEEMED"

      redemptions = []
      self.players.each do |player|
        redemption = SweetTooth::Redemption.create(
          :customer_id => self.players.first.st_id,
          :redemption_option_id => 'rop_GV5tHuqGcIdJEk'
        )
        redemptions.push(redemption.id)
      end

      # self.st_redemption_ids = redemptions.join(",")

      puts "Redemption created: " + redemptions.join(",")
      # self.signed_up_on = Date.today
    end
end
