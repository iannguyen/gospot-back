class Api::BetsController < ApplicationController
  def new
  end

  def index
    @bets = Bet.includes(:team).includes(:skins).includes(:user).all
    render json: @bets
  end

  def create
    skin_ids = bet_params[:skin_ids].map(&:to_i)
    skins = Skin.where(id: skin_ids).all
    sum = skins.sum(:price)
    match = Match.find(params[:match_id])
    @bet = Bet.new(bet_params.except('skins'))
    @bet.skins = skins
    if sum >= 10 && match.open && @bet.save
      render json: @bet, status: 201
    elsif sum < 10
      render json: { failures: 'Minimum bet $10' }, status: 422
    else
      render json: { failures: @bet.errors.full_messages }, status: 422
    end
  end

  def destroy
    @bet = Bet.find(params[:id])
    @bet.destroy
    render json: @bet, status: 201
  end

  private

  def bet_params
    params.require(:bet).permit(:user_id, :team_id, :match_id, skin_ids: [])
  end
end
