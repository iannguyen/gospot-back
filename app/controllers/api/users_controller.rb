class Api::UsersController < ApplicationController
  before_action :authenticate_user!
  def current
    user = User.includes(:skins).includes(:payouts => :skins).find(current_user.id)
    render json: user
  end
end
