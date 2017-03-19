module Parser
	def is_correct?(response)
		if !(response.code =~ /2[0-9][0-9]/)
			puts "Error!, code of error is: #{response.code}\n".color(:red)
			return false
		else
			puts "All is correct, code is #{response.code}\n".colorize(:green)
			puts "#{response.body}".colorize(:blue)
			return true
		end
	end
end