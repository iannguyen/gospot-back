class AddPayoutIdToSkins < ActiveRecord::Migration
  def change
    add_column(:skins, :payout_id, :integer)
    add_index(:skins, :payout_id)
  end
end
