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

  private

  def self.generate_bets!
    matches = Match.all
    users = User.where(id: [(1..16)]).all

    matches.each do |match|
      users.each do |user|
        user.id <= 8 ? team_num = match.team_1_id : team_num = match.team_2_id

        random_user_skins = Skin.send(:random_skins, user.id)

        bet = user.bets.new(match_id: match.id, team_id: team_num, skins: random_user_skins)
        bet.save
      end
    end
  end
end
