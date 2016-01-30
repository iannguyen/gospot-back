class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.boolean :open, null: false, default: false
      t.string :location, null: false
      t.integer :team_1_id, null: false
      t.integer :team_2_id, null: false
      t.integer :team_1_score, null: false, default: 0
      t.integer :team_2_score, null: false, default: 0
      t.integer :team_1_odds, null: false, default: 0
      t.integer :team_2_odds, null: false, default: 0
      t.timestamps null: false
    end
    add_index(:matches, :team_1_id)
    add_index(:matches, :team_2_id)
  end
end
