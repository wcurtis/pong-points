class AddGameAndPlayerRelations < ActiveRecord::Migration
  def change
    create_table :games_players do |t|
      t.belongs_to :game
      t.belongs_to :player
    end
  end
end
