class AddWinnerForeignKey < ActiveRecord::Migration

  def change
    # Remove any orphan rows before adding foreign keys, or else we will get errors
    begin
      execute "delete from games where winner not in (select id from players);" 
    rescue
      puts "Ignoring irreversable migration of clearing orphan rows"
    end

    add_foreign_key "games", "players", column: "winner", dependent: :delete, name: "games_winner_fk"
  end
end
