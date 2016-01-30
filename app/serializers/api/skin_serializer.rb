class Api::SkinSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :user_id, :bet_id, :payout_id
end
