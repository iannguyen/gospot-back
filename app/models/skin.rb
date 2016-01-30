class Skin < ActiveRecord::Base
  validates :name, :price, :user_id, presence: true

  belongs_to :user
  belongs_to :bet
  belongs_to :payout
end
