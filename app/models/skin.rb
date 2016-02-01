class Skin < ActiveRecord::Base
  validates :name, :price, :user_id, presence: true

  belongs_to :user
  belongs_to :bet
  belongs_to :payout, dependent: :destroy

  private

  def self.random_skins(user_id)
    skins = []
    selection = [
      Skin.new(name: 'AK-47: Elite Build', price: 0.77, user_id: user_id),
      Skin.new(name: 'USP-S: Guardian', price: 1.23, user_id: user_id),
      Skin.new(name: 'M4A4: Desert Strike', price: 4.00, user_id: user_id),
      Skin.new(name: 'AWP: Worm God', price: 5.00, user_id: user_id),
      Skin.new(name: 'M4A1-S: Hyper Beast', price: 5.00, user_id: user_id),
      Skin.new(name: 'Karmabit: Marble Fade', price: 500, user_id: user_id)
    ]

    10.times do
      skin = selection.sample.dup
      skin.save
      skins << skin
    end
    skins
  end
end
