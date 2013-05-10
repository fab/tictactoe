class Creategames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :winner_id
      t.string :game_moves
    end
  end
end
