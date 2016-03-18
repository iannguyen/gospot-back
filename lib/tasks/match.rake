desc 'Start the matches and payout'

task start_matches: :environment do
  sleep(15)
  utc_hour = Time.now.utc.hour
  pst_hour = (utc_hour - 8) % 24
  pst_hour += 1 if Time.now.dst?
  matches = Match.where(start_hour: pst_hour).all
  puts Time.now
  puts utc_hour
  puts pst_hour
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
