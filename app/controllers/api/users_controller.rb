class Api::UsersController < ApplicationController
  def index
    render json: User.where(email: params[:email])
                     .includes(:skins).includes(payouts: :skins)
  end
end
