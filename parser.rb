require 'optparse'
class Parser
  attr_accessor :response, :options
  def initialize(opts = {})
    @options = opts
  end
  class << self
    def parse(response)
      if !(@response.code =~ /2[0-9][0-9]/)
        STDOUT.puts "Error!, code of error is: #{@response.code}\n".color(:red)
      else
        STDOUT.puts "All is correct, code is #{@response.code}\n".colorize(:green)
        STDOUT.puts "#{@response.body}".colorize(:blue)
      end
    end
    def treatment(options)
      @options = {}
      OptionParser.new do |parser|
        parser.banner = "Usage: my_curl.rb [options]"
        parser.on("-h", "--help", "Shows this help message") do ||
          puts parser
        end
        parser.on("-u=url", "--url=url", "Settings the url for parsing") do |url|
          @options[:url] = url
        end
      end.parse!
    end
    def init_request
      uri = URI.parse("#{@options[:url]}")
      @response = Net::HTTP.get_response(uri)
    end
  end
end