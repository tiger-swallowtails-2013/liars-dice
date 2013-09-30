class CreateGamesTable < ActiveRecord::Migration
  def change
    create_table :games do |t|

      t.timestamps
    end
  end
end
