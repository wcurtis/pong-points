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

    if user.st_id.nil?
      # Add to ST
      stUserData = {
        "email" => 'test4@example.com'
      }
      postData = {
        :headers => headers,
        :body => stUserData.to_json
      }
      response = HTTParty.post('https://api.sweettooth.io/v1/customers', postData)
      stUser = JSON.parse(response.body)
      puts "You have initialized " + user.email;
      puts stUser['id']
      user.st_id = stUser['id']
      user.st_points_balance = stUser['points_balance']
      user.save!
    end
  end

  def name
    return first_name + ' ' + last_name
  end
end
