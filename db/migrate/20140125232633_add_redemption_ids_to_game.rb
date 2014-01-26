class AddRedemptionIdsToGame < ActiveRecord::Migration
  def change
    add_column :games, :st_redemption_ids, :string
  end
end
