module BinpackHelper
  class PayoutTable
    attr_reader :skins, :profits, :max, :skins_hash, :winners, :bp_table

    OVERPAY_CONST = 1.10

    def initialize(skins, winners, site_rake)
      @skins = skins
      @winners = winners
      @site_rake = site_rake
      @profits = pull_profits
      @max = @profits.first.round
      @skins_hash = generate_skins_frequency
      @bp_table = generate_bp_table!
    end

    def payout!
      site_profit = cashout(@site_rake)
      site_profit.each(&:destroy)
      @winners.keys.each_with_index do |user_id, idx|
        user_payout = @winners[user_id][:payout]
        user_profit = cashout(@profits[idx], idx)
        user_profit.each do |skin|
          skin.bet_id = nil
          skin.user_id = user_id
        end
        user_payout.skins += user_profit
        user_payout.save
      end
      @winners
    end

    private

    def find_optimal(amount)
      payout = []
      until amount <= 0 || @bp_table[amount].nil? || @bp_table[amount].zero?
        payout << @bp_table[amount]
        amount = (amount - @bp_table[amount]).round
      end
      payout.sort!.reverse!
    end

    def cashout(amount, idx = -1)
      success = false
      payment = []
      until success
        optimal = find_optimal(amount)
        break if optimal.empty?
        optimal.each do |price|
          if !@skins_hash[price].empty?
            payment << @skins_hash[price].pop
            amount -= payment.last.price.round
            if @profits[idx + 1]
              @max = [amount, @profits[idx + 1]].max
            else
              @max = amount
            end
            success = true
          else
            @skins_hash.delete(price)
            reset_table!
            success = false
            break
          end
        end
      end
      payment
    end

    def generate_skins_frequency
      hash = {}
      @skins.each do |skin|
        hash[skin.price] || hash[skin.price] = []
        hash[skin.price] << skin
      end
      hash
    end

    def pull_profits
      payouts = []
      @winners.each { |_user_id, info| payouts << info[:profit].round }
      payouts
    end

    def generate_bp_table!
      skin_count = [0]
      last_skins = [0]
      prices = @skins_hash.keys.sort

      (1..@max).each do |amt|
        prices.each do |price|
          if price > amt && price <= (amt * OVERPAY_CONST).ceil
            skin_count[amt] = 1
            last_skins[amt] = price
            next
          elsif price > (amt * OVERPAY_CONST)
            break
          end

          low_rem = (amt - price).floor
          upper_rem = (amt - price).ceil

          if skin_count[low_rem].nil?
            skin_count[low_rem] = 0
            last_skins[low_rem] = 0
          end

          low_rem_optimal = [skin_count[low_rem] + 1, skin_count[-1] + 1].min

          if skin_count[upper_rem]
            optimal = [low_rem_optimal, skin_count[upper_rem] + 1].min
          else
            optimal = low_rem_optimal
          end

          next if skin_count[amt] && skin_count[amt] < optimal

          skin_count[amt] = optimal

          if !last_skins[low_rem].zero?
            last_skins[amt] = last_skins[low_rem]
          else
            last_skins[amt] = price
          end
        end
      end
      @bp_table = last_skins
    end

    def reset_table!
      generate_bp_table!
    end
  end
end
