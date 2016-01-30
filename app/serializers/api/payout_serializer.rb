class Api::PayoutSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :total

  # has_many :skins
  # has_many :skins, embed: :ids, key: :skins, embed_in_root: true
end
