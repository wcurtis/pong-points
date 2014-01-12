class Game < ActiveRecord::Base
  has_and_belongs_to_many :players

  after_update do |game|
    if game.status == 'finished' && game.winner

      credentials = "sk_4QnT9xxvKtLzAi6Hst72bp1Y:"

      headers = {
        'Accept' => "application/json",
        'Content-Type' => "application/json",
        'Authorization' => "Basic #{Base64.encode64(credentials)}"
      }

      # Send game win event to ST
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

      # TODO: Refresh user points here

      puts "Sent event to ST: " + stEvent['id'];
    end
  end
end
