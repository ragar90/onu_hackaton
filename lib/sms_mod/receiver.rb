module SmsMod
	class Receiver

		attr_accessor :message

		def initialize
			@client = Twilio::REST::Client.new ENV['TWILIO_ASID'], ENV['TWILIO_ATOK']
		end

		def get_messages
			last_date = UserMessage.last.date_sent.strftime("%Y-%m-%d") rescue Time.now.strftime("%Y-%m-%d")

			@client.account.sms.messages.list({:date_sent => last_date}).each do |sms|
				um = UserMessage.find_by_message_id(sms.sid) rescue nil
				if um.nil?
					user = User.compare_number(sms.from)
					if !user.nil?
						@message = sms.body
						data_hash = strip_message(%w(command amount plataform_id account_id))
						user.register_message(sms.sid, sms.body, sms.from, sms.date_sent, data_hash)
					end
				end
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