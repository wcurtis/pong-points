class Game < ActiveRecord::Base

  has_and_belongs_to_many :players

  before_create :redeemGamePlay

  after_update do |game|

    if game.status == 'finished' && game.winner && game.st_activity_id == nil

      winner = nil;
      loser = nil;

      self.players.each do |player|
        if player.id == game.winner
          winner = player
        else
          loser = player
        end
      end


      # The idea with the handicap is if you beat someone with a higher points amount 
      # than you, you should earn more points than if they beat you.
      # 
      # The algorithm takes the fraction of points the loser has of the winners
      # and multiplies that by 100 (since ST dosn't support decimal step funcitons yet <-- GET ON THIS Y'ALL!!!)
      # 
      # Eg. Mike (1000 points) beats Bill (500 points) then Mike's handicap is 500/1000*100 = 50
      #     --
      #     Bill (500 points) beats Mike (1000) points then Bill's handicap is 1000/500*100 = 200
      #     --
      #     So Bill would earn more points for a win than Mike because of where they are in the standings
      # 
      handicap = (loser.st_points_balance.to_f / winner.st_points_balance.to_f) * 100;

      # Send game win activity to Sweet Tooth to earn points
      activity = SweetTooth::Activity.create(
        "customer_id"  => winner.st_id,
        "verb"   => "game_win",
        "object" => {
          "handicap" => handicap
        }
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

  def cancel

    spendingsIds = self.st_redemption_ids.split(',')

    # Cancel previous spendings so our players get their points back
    spendingsIds.each do |id|
      spending = SweetTooth::Spending.retrieve(id)
      spending.cancel
    end

    self.status = 'canceled'
    self.save!
  end

  private
    def redeemGamePlay
      redemptions = []

      # Spend points on game play
      # TODO: Catch errors if a player has insufficient funds
      self.players.each do |player|
        spending = SweetTooth::Spending.create(
          :customer_id => player.st_id,
          :spending_option_id => 'game_play'
        )
        redemptions.push(spending.id)
      end

      self.st_redemption_ids = redemptions.join(",")

      puts "Spending created: " + redemptions.join(",")
    end
end
