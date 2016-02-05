desc 'Start the matches and payout'

task start_match: :environment do

  sleep(30)
  matches = Match.all
  pst_hour = (Time.now.utc.hour + 12) % 24
  matches.each do |match|
    if match.start_hour == pst_hour
      match.send(:start!)
    end
  end

end

desc 'Reset the matches and clear bets'

task reset_match: :environment do

  matches = Match.all
  matches.each { |match| match.send(:reset!) }

end
