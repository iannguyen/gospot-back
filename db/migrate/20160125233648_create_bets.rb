class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.integer :match_id, null: false
      t.timestamps null: false
    end
    add_index(:bets, :user_id)
    add_index(:bets, [:user_id, :match_id])
    add_index(:bets, :team_id)
  end
end
