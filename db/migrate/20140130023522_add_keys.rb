class AddKeys < ActiveRecord::Migration

  def change
    # Remove any orphan rows before adding foreign keys, or else we will get errors
    begin
      execute "delete from games_players where player_id not in (select id from players);" 
      execute "delete from games_players where game_id not in (select id from games);" 
    rescue
      puts "Ignoring irreversable migration of clearing orphan rows"
    end

    add_foreign_key "games_players", "games", dependent: :delete, name: "games_players_game_id_fk"
    add_foreign_key "games_players", "players", dependent: :delete, name: "games_players_player_id_fk"
  end
end
