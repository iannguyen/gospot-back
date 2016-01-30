class Api::SkinsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Skin.all
  end

  def new
  end

  def create
    @skin = current_user.skins.new(skin_params)
    if @skin.save
      render json: @skin, status: 201
    else
      render json: { failures: @skin.errors.full_messages }, status: 422
    end
  end

  def update
    @skin = Skin.find(params[:id])
    if @skin.update(skin_params)
      render json: @skin, status: 201
    else
      render json: { failures: @skin.errors.full_messages }, status: 422
    end
  end

  def destroy
    @skin = Skin.find(params[:id])
    @skin.destroy!
    render json: @skin, status: 201
  end

  private

  def skin_params
    params.require(:skin).permit(:name, :price, :user_id)
  end
end
