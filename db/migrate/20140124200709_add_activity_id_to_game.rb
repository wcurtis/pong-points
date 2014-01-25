class AddActivityIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :st_activity_id, :string
  end
end
