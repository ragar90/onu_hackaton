module SmsMod
	class Sender

		attr_accessor :client

		def initialize
			@client = Twilio::REST::Client.new ENV['TWILIO_ASID'], ENV['TWILIO_ATOK']
		end

		def send_message(number, message)
			@obj = result = @client.account.sms.messages.create(
			  :from => '+16208601650',
			  :to => "+503#{number}",
			  :body => message
			)

			puts @obj
		end

	end
end