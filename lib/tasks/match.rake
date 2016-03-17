desc 'Start the matches and payout'

task start_matches: :environment do
  sleep(15)
  utc_hour = Time.now.utc.hour
  utc_hour += 1 if Time.now.dst?
  pst_hour = (utc_hour - 8) % 24
  matches = Match.where(start_hour: pst_hour).all
  matches.each do |match|
    puts "MATCH STARTED:: PST_HOUR - #{pst_hour} : START_HOUR - #{match.start_hour}"
    match.send(:start!)
  end
end

desc 'Reset the matches and clear bets'

task reset_matches: :environment do
  puts "MATCHES RESET!"
  matches = Match.all
  matches.each { |match| match.send(:reset!) }
end
