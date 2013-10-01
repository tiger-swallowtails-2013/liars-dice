class AddPlayersTable < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :number_of_dice, default: 5
      t.string :current_roll
      t.string :current_claim
      t.belongs_to :game

      t.timestamps
    end
  end
end
