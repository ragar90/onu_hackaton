module SmsMod
	class Receiver

		attr_accessor :message

		def initialize(message)
			@message = message
		end

		def strip_message(options = [])
			result = {}
			data = @message.split(",")
			options.each_with_index { |k, i| result[k] = data[i] }
			return result
		end

	end
end