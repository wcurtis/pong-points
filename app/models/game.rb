class Game < ActiveRecord::Base
  has_and_belongs_to_many :players

  after_update do |game|
    if game.status == 'finished' && game.winner

      credentials = "sk_hwHybrSsMLvUj7Crt8Cz142Y:"

      headers = {
        'Accept' => "application/json",
        'Content-Type' => "application/json",
        'Authorization' => "Basic #{Base64.encode64(credentials)}"
      }

      # Create ST User if we haven't yet
        # Add to ST
        stUserData = {
          "customer_id"  => Player.find(game.winner).st_id,
          "event_type"   => "game_win"
        }
        postData = {
          :headers => headers,
          :body => stUserData.to_json
        }
        response = HTTParty.post('https://api.sweettooth.io/v1/events', postData)
        stEvent = JSON.parse(response.body)
        puts stEvent['id']

        # TODO: Refresh user points here

        puts "Sent event to ST: " + stEvent['id'];
      # Post event to ST
    end
  end
end
