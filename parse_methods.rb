module Parser
	def is_correct?(response)
		if !(response.code =~ /2[0-9][0-9]/)
			STDOUT.puts "Error!, code of error is: #{response.code}\n".color(:red)
		else
			STDOUT.puts "All is correct, code is #{response.code}\n".colorize(:green)
			STDOUT.puts "#{response.body}".colorize(:blue)
      #
		end
	end
	def switch_for_first_param
		options = {}
		OptionParser.new do |parser|
			parser.banner = "Usage: my_curl.rb [options] URL"
			parser.on("-h", "--help", "Shows this help message") do ||
				puts parser
			end
		end.parse!
  end
end