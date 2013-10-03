class AddTurnsToGame < ActiveRecord::Migration
  def change
    add_column :games, :turns, :string
  end

end
