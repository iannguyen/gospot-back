desc 'Start the matches and payout'

task start_matches: :environment do
  sleep(15)
  utc = Time.now.utc
  pst_hour = utc.in_time_zone('Pacific Time (US & Canada)').hour
  matches = Match.where(start_hour: pst_hour).all
  puts "Current PST_HOUR: #{pst_hour}"
  matches.each do |match|
    puts "MATCH ID: #{match.id} STARTED"
    match.send(:start!)
  end
end

desc 'Reset the matches and clear bets'

task reset_matches: :environment do
  puts 'MATCHES RESET!'
  matches = Match.all
  matches.each { |match| match.send(:reset!) }
end
