class AddFinalTeamOddsToMatches < ActiveRecord::Migration
  def change
    add_column(:matches, :final_team_1_odds, :float)
    add_column(:matches, :final_team_2_odds, :float)
  end
end
