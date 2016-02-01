desc 'Start the match and payout'

task start_match: :environment do

  match = Match.first
  match.send(:start!)

end

desc 'Reset the match and clear bets'

task reset_match: :environment do

  match = Match.first
  match.send(:reset!)

end
