class Api::MatchSerializer < ActiveModel::Serializer
  attributes :id, :team_1_score, :team_2_score, :team_1_odds, :team_2_odds, :location, :open, :team_1, :team_2, :start_hour, :total

  has_many :teams, embed: :ids, key: :teams, embed_in_root: true
  has_many :bets, embed: :ids, key: :bets, embed_in_root: true
end
