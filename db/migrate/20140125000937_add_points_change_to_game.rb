class AddPointsChangeToGame < ActiveRecord::Migration
  def change
    add_column :games, :st_points_change, :integer
  end
end
