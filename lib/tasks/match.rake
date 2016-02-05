desc 'Start the matches and payout'

task start_matches: :environment do

  sleep(30)
  pst_hour = (Time.now.utc.hour + 12) % 24
  pst_hour = 20
  matches = Match.where(start_hour: pst_hour).all
  matches.each do |match|
    if match.start_hour == pst_hour
      match.send(:start!)
    end
  end

end

desc 'Reset the matches and clear bets'

task reset_matches: :environment do

  matches = Match.all
  matches.each { |match| match.send(:reset!) }

end
