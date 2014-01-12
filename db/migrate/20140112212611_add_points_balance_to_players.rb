class AddPointsBalanceToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :st_id, :string
    add_column :players, :st_points_balance, :integer
  end
end
