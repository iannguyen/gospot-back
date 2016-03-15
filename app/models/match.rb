class Match < ActiveRecord::Base
  include BinpackHelper

  RAKE_CONST = 0.05

  validates :team_1_id, :team_2_id, :team_1_score, :team_2_score, :team_1_odds,
            :team_2_odds, :location, :start_hour, presence: true
  validates :team_1_score, :team_2_score, inclusion: { in: (0..16).to_a }

  belongs_to :team_1, class_name: 'Team', foreign_key: 'team_1_id'
  belongs_to :team_2, class_name: 'Team', foreign_key: 'team_2_id'

  has_many :bets
  has_many :skins, through: :bets
  has_many :users, through: :bets
  has_many :teams, through: :bets

  attr_accessor :total, :teams

  def over?
    team_1_score == 16 || team_2_score == 16
  end

  def winner
    team_1_score == 16 ? team_1 : team_2 if over?
  end

  def winner_mulplier
    (total / winner.total) - 1
  end

  def loser
    team_1_score == 16 ? team_2 : team_1 if over?
  end

  def teams
    [team_1, team_2]
  end

  def total
    skins.sum(:price)
  end

  def team_1_odds
    return final_team_1_odds if over?
    @team_1_odds ||= (team_1.total / total).to_f.round(2)
  end

  def team_2_odds
    return final_team_2_odds if over?
    (team_2.total / total).to_f.round(2)
  end

  def distribute
    winners = winner_returns
    loser_skins = loser.skins.order(:price).reverse_order
    site_rake = total * RAKE_CONST
    payout_table = PayoutTable.new(loser_skins, winners, site_rake)
    payout_table.payout!
    destroy_bets!
  end

  private

  def start!
    until over?
      sleep(rand(90))
      round_winner = rand(2)
      round_winner.zero? ? self.team_1_score += 1 : self.team_2_score += 1
      puts "#{team_1.name} #{team_1_score} : #{team_2_score} #{team_2.name}"
      save
    end
    save_odds
    distribute
  end

  def winner_returns
    winners = {}
    multiplier = winner_mulplier
    winning_team_bets = Bet.includes(:skins)
                           .includes(:team)
                           .includes(:user)
                           .where(team_id: winner.id)
                           .sort_by(&:total).reverse!

    winning_team_bets.each do |bet|
      returned_payout = bet.user.payouts.new(skins: bet.skins)
      winners[bet.user_id] = {
        payout: returned_payout,
        profit: (bet.total * multiplier)
      }
      bet.skins.each { |skin| skin.bet_id = nil }
    end
    winners
  end

  def destroy_bets!
    Bet.where(match_id: id).destroy_all
  end

  def reset!
    self.team_1_score = 0
    self.team_2_score = 0
    self.final_team_1_odds = nil
    self.final_team_2_odds = nil
    save
  end

  def save_odds
    self.final_team_1_odds = team_1_odds
    self.final_team_2_odds = team_2_odds
    save
  end
end
