require 'optparse'
#autoload :HelperMethods, "helper_methods"
load "./parse_methods.rb"
class Parser
  include ParseMethods
  attr_accessor :response, :options
  def initialize(opts = {})
    @options = opts
  end
  def post_query
    uri = URI.parse(options[:url])
    response = Net::HTTP.post_form(uri, @options[:data])
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(@options[:data])
    response = http.request(request)
  end
  def post_data_to_site(parser)
    parser.on("-d=data", "--data=data", "Settings the url for parsing") do |data|
    data = parse_data(data)
    make_hash_from_data(data)
    end
  end
  def parse_page(parser)
    parser.on("-u", "--url=url", "Settings the url for parsing") do |url|
      @options[:url] = url
      init_request
      parse
    end
  end
  def parse
    if !(@response.code =~ /2[0-9][0-9]/)
      STDOUT.puts "Error!, code of error is: #{@response.code}\n".colorize(:red)
    else
      STDOUT.puts "All is correct, code is #{@response.code}\n".colorize(:green)
      STDOUT.puts "#{@response.body}".colorize(:blue)
    end
  end
  def help(parser)
    parser.banner = "Usage: my_curl.rb [options] -u [url]"
    parser.on("-h", "--help", "Shows this help message") do ||
      puts parser
    end
  end
  def treatment
    @options = {}
    @options[:data] = {}
    OptionParser.new do |parser|
      help(parser)
      parse_page(parser)
      post_data_to_site(parser)
    end.parse!
  end
  def init_request
    uri = URI.parse("#{@options[:url]}")
    @response = Net::HTTP.get_response(uri)
  end
end