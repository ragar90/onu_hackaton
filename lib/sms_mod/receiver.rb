module SmsMod
	class Receiver

		attr_accessor :message

		def initialize
			@client = Twilio::REST::Client.new ENV['TWILIO_ASID'], ENV['TWILIO_ATOK']
		end

		def get_messages
			@client.account.sms.messages.list({:date_sent => '2013-05-26'}).each do |sms|
  				puts sms.id
			end
		end

		def strip_message(options = [])
			result = {}
			data = @message.split(",")
			options.each_with_index { |k, i| result[k] = data[i] }
			return result
		end

	end
end