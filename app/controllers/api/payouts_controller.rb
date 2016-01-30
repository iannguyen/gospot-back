class Api::PayoutsController < ApplicationController

  def destroy
    @payout = Payout.find(params[:id])
    @payout.skins.each do |skin|
      skin.payout_id = nil
      skin.save
    end
    @payout.destroy
    render json: @payout, status: 201
  end
end
