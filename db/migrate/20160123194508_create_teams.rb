class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :match_id, null: false
      t.timestamps null: false
    end
    add_index(:teams, :match_id)
  end
end
