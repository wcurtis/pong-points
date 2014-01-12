require "httparty"

class Player < ActiveRecord::Base
  has_and_belongs_to_many :games

  after_initialize do |user|

    credentials = "sk_hwHybrSsMLvUj7Crt8Cz142Y:"

    headers = {
      'Accept' => "application/json",
      'Content-Type' => "application/json",
      'Authorization' => "Basic #{Base64.encode64(credentials)}"
    }

    stUserData = {
      "email" => user.email
    }

    response = HTTParty.get('https://api.sweettooth.io/v1/customers', { :headers => headers })
    stUser = JSON.parse(response.body)
    puts "You have initialized " + user.email;
    puts stUser.inspect
  end

  def name
    return first_name + ' ' + last_name
  end
end
