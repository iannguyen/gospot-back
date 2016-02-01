require 'rails_helper'

RSpec.describe 'Distributing with a 5% site rake' do
  before :each do
    @ian = User.create(email: 'ian@test.com', password: 'lalalala')
    @don = User.create(email: 'don@test.com', password: 'lalalala')
    @bane = User.create(email: 'bane@test.com', password: 'lalalala')
    @blaka = User.create(email: 'blaka@test.com', password: 'lalalala')

    @wow = Team.create(name: 'wow')
    @ohno = Team.create(name: 'ohno')

    @game = Match.create(team_1_id: @wow.id, team_2_id: @ohno.id, location: 'dust2', start_hour: 0, open: false, team_1_score: 16, team_2_score: 0)

    @game.team_1 = @wow
    @game.team_2 = @ohno
  end

  describe 'a 50/50 payout' do
    it 'rakes if possible and pays the winning betters' do
      @ian.skins = [
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5)
      ]
      @don.skins = [
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5)
      ]

      @game.bets = [
        @ian.bets.create(skins: @ian.skins, team_id: @wow.id),
        @don.bets.create(skins: @don.skins, team_id: @ohno.id)
      ]

      @game.distribute

      expect(@ian.payouts.first.total).to eq(95)
      expect(@don.payouts.first).to be_nil
    end
  end

  describe 'for some reason when there is a $500 skin in there' do
    it 'prioritizes highest better and always returns original skins' do
      @ian.skins = [
        Skin.create(name: 'M4', price: 500),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5)
      ]
      @don.skins = [
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5)
      ]
      @bane.skins = [
        Skin.create(name: 'M4', price: 500)
      ]
      @blaka.skins = [
        Skin.create(name: 'M4', price: 500),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5),
        Skin.create(name: 'M4', price: 5)
      ]

      @game.bets = [
        @ian.bets.create(skins: @ian.skins, team_id: @wow.id),
        @don.bets.create(skins: @don.skins, team_id: @wow.id),
        @bane.bets.create(skins: @bane.skins, team_id: @ohno.id),
        @blaka.bets.create(skins: @blaka.skins, team_id: @ohno.id)
      ]

      @game.distribute

      expect(@ian.payouts.first.total).to eq(1010)
      expect(@don.payouts.first.total).to eq(50)
      expect(@bane.payouts.first).to be_nil
      expect(@blaka.payouts.first).to be_nil
    end
  end

  describe 'when an overpay makes sense' do
    it 'allows a 10% overpay to distribute winnings to others' do
      @ian.skins = [
        Skin.create(name: 'M4', price: 450),

      ]
      @don.skins = [
        Skin.create(name: 'M4', price: 500),

      ]
      @bane.skins = [
        Skin.create(name: 'M4', price: 500),

      ]
      @blaka.skins = [
        Skin.create(name: 'M4', price: 500),

      ]

      @game.bets = [
        @ian.bets.create(skins: @ian.skins, team_id: @wow.id),
        @don.bets.create(skins: @don.skins, team_id: @wow.id),
        @bane.bets.create(skins: @bane.skins, team_id: @ohno.id),
        @blaka.bets.create(skins: @blaka.skins, team_id: @ohno.id)
      ]

      @game.distribute

      expect(@ian.payouts.first.total).to eq(950)
      expect(@don.payouts.first.total).to eq(1000)
      expect(@bane.payouts.first).to be_nil
      expect(@blaka.payouts.first).to be_nil
    end
  end
end
