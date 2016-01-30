class Api::UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_many :skins, embed: :ids, key: :skins, embed_in_root: true
  has_many :payouts, embed: :ids, key: :payouts, embed_in_root: true
end
