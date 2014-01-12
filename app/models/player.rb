require "httparty"

class Player < ActiveRecord::Base
  has_and_belongs_to_many :games

  after_initialize do |user|

    credentials = "sk_4QnT9xxvKtLzAi6Hst72bp1Y:"

    headers = {
      'Accept' => "application/json",
      'Content-Type' => "application/json",
      'Authorization' => "Basic #{Base64.encode64(credentials)}"
    }

    # Create ST User if we haven't yet
    if user.st_id.nil?
      # Add to ST
      stUserData = {
        "first_name"  => user.first_name,
        "last_name"   => user.last_name,
        "email"       => user.email
      }
      postData = {
        :headers => headers,
        :body => stUserData.to_json
      }
      response = HTTParty.post('https://api.sweettooth.io/v1/customers', postData)
      stUser = JSON.parse(response.body)
      puts stUser['id']
      user.st_id = stUser['id']
      user.st_points_balance = stUser['points_balance']
      user.save!

      puts "Added user to ST: " + user.email;

      # Send signup event to ST
      stSignupData = {
        "customer_id"  => user.st_id,
        "event_type"   => "signup"
      }
      postData = {
        :headers => headers,
        :body => stSignupData.to_json
      }
      response = HTTParty.post('https://api.sweettooth.io/v1/events', postData)
      stEvent = JSON.parse(response.body)

      # TODO: Refresh user points here

      puts "Sent signup event to ST: " + stEvent['id'];
    end

    # Fetch and update points balance
    # TODO: Cache these values and invalidate cache when event is sent
    options = {
      :headers => headers,
    }
    response = HTTParty.get('https://api.sweettooth.io/v1/customers/' + user.st_id.to_s, options)
    stUser = JSON.parse(response.body)
    user.st_points_balance = stUser['points_balance']
    user.save!

    puts "Updated points balance for: " + user.email + " to " + user.st_points_balance.to_s;
  end

  def name
    return first_name + ' ' + last_name
  end
end
