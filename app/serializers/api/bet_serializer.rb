class Api::BetSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :team_id, :match_id, :total

  has_one :user, embed: :id, key: :user, embed_in_root: true, serializer: Api::BasicUserSerializer
  has_many :skins, embed: :ids, key: :skins, embed_in_root: true
end
