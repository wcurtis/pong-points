class Player < ActiveRecord::Base
  has_and_belongs_to_many :games

  def name
    return first_name + ' ' + last_name
  end
end
