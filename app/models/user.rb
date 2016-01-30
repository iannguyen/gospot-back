class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :skins, -> { where bet_id: nil }
  has_many :bets
  has_many :payouts

  def ensure_authentication_token
    self.authentication_token = User.generate_authentication_token
  end

  private

  def self.generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
