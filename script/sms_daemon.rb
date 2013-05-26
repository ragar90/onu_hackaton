config = ActiveRecord::Base.remove_connection

pid = fork do
	ActiveRecord::Base.establish_connection(config)

	while true
		rec = SmsMod::Receiver.new
		rec.get_messages
		sleep 5
	end
end

ActiveRecord::Base.establish_connection(config)

puts "PID of sms_daemon.rb: #{pid}"