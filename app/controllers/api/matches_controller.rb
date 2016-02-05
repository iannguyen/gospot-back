class Api::MatchesController < ApplicationController
  def index
    @matches = Match.includes(bets: [:skins, :user]).all
    render json: @matches, each_serializer: Api::BasicMatchSerializer
  end

  def show
    @match = Match.includes(bets: [:skins, :user]).find(params[:id])
    render json: @match, serializer: Api::MatchSerializer
  end
end
