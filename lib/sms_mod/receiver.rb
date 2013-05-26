require 'daemons'

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
						UserMessage.create!(user_id: user.id, message_id: sms.sid, message: sms.message, from: sms.from, date_sent: sms.date_sent)

						@message = sms.message
						result = strip_message(%w(password amount command account_id))
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