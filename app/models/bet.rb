class Bet < ActiveRecord::Base
  validates :user_id, :match_id, :team_id, presence: true
  validates :user_id, uniqueness: { scope: :match_id }
  validates :skins, length: { maximum: 10 }

  belongs_to :user
  belongs_to :match
  belongs_to :team

  has_many :skins

  attr_accessor :total

  validates :total, numericality: { greater_than_or_equal_to: 10 }

  def total
    skins.inject(0) { |a, e| a + e.price }.round(2)
  end
end
