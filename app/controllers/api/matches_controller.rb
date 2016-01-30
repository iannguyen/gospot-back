class Api::MatchesController < ApplicationController
  def index
    render json: Match.includes(bets: [:skins, :user]).all
  end

  def show
    @match = Match.includes(bets: [:skins, :user]).find(params[:id])
    render json: @match
  end
end
