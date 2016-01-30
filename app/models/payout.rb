class Payout < ActiveRecord::Base
  validates :user_id, presence: true

  belongs_to :user
  has_many :skins

  def total
    skins.inject(0) { |a, e| a + e.price }.round(2)
  end
end
