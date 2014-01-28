require "httparty"

class Player < ActiveRecord::Base
  has_and_belongs_to_many :games
  
  before_destroy :delete_st_customer

  after_initialize do |user|

    # Create ST User if we haven't yet
    if user.st_id.nil?

      # Create the customer on ST
      stUser = SweetTooth::Customer.create(
        :first_name  => user.first_name,
        :last_name   => user.last_name,
        :email       => user.email
      )
      user.st_id = stUser.id
      user.st_points_balance = stUser.points_balance
      user.save!
      puts "Added user to ST: " + user.email;

      # Send a signup event to ST
      activity = SweetTooth::Activity.create(
        :customer_id  => user.st_id,
        :verb   => "signup"
      )
      puts "Sent signup event to ST: " + activity.id;
    end

    # Fetch and update the customer's points balance
    stUser = SweetTooth::Customer.retrieve(user.st_id);
    user.st_points_balance = stUser.points_balance
    user.save!
    puts "Updated points balance for: " + user.email + " to " + user.st_points_balance.to_s;
  end

  def name
    return first_name + ' ' + last_name
  end

  private
    def delete_st_customer
      customer = SweetTooth::Customer.retrieve(self.st_id);
      customer.delete
      puts "Deleted customer with st_id: " + customer.id;
    end
end
