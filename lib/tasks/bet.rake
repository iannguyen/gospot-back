desc 'Create new bets'

task generate_bets_and_skins: :environment do
  Bet.send(:generate_bets!)
end
