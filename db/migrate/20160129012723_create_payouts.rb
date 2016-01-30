class CreatePayouts < ActiveRecord::Migration
  def change
    create_table :payouts do |t|
      t.integer :user_id, null: false
      t.timestamps null: false
    end
    add_index(:payouts, :user_id)
  end
end
