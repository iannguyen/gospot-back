class Team < ActiveRecord::Base
  validates :name, presence: true

  has_many :bets
  has_many :skins, through: :bets

  attr_accessor :match, :total

  def match
    Match.where('team_1_id  = ? OR team_2_id = ?', id, id).first
  end

  def total
    skins.sum(:price)
    # skins.inject(0) { |accum, skin| accum + skin.price }.round(2)
  end
end
