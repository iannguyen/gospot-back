class CreateSkins < ActiveRecord::Migration
  def change
    create_table :skins do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.integer :user_id, null: false
      t.integer :bet_id
      t.timestamps null: false
    end
    add_index(:skins, :user_id)
    add_index(:skins, :bet_id)
  end
end
