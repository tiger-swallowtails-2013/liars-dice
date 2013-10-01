class AddBullshitToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :bullshit, :boolean, default: false
  end
end
