require 'optparse'
load "./parse_methods.rb"
class Parser
  include ParseMethods
  attr_accessor :response, :data, :url, :ssl
  def initialize(dt = {}, url_without_parse = '', resp ={}, check = false)
    @data = dt
    @url = url_without_parse
    @response = resp
    @ssl = false
  end
  def post_query
    uri = URI.parse(@url)
    @response = Net::HTTP.post_form(uri, @data)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(@data)
    @response = http.request(request)
  end
  def make_ssl_connection(parser)
    parser.on("-s", "--ssl", "Settings the url for parsing".colorize(:light_blue)) do |ssl|
      @ssl = true
    end
  end
  def post_data_to_site(parser)
    parser.on("-d=data", "--data=data", "Data for POST request to server".colorize(:light_blue)) do |data|
    data = parse_data(data)
    make_hash_from_data(data)
    post_query
    end
  end
  def parse_page(parser)
    parser.on("-u", "--url=url", "Settings the url for parsing".colorize(:light_blue)) do |url|
      @url = url
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
    parser.banner = "Usage: ruby my_curl.rb -u [url] [options]".colorize(:light_magenta)
    parser.on("-h", "--help", "Shows this help message".colorize(:light_blue)) do ||
      puts parser
    end
  end
  def treatment
    @data = {}
    OptionParser.new do |parser|
      help(parser)
      make_ssl_connection(parser)
      parse_page(parser)
      post_data_to_site(parser)
      puts parser.banner.colorize(:red) if url == ""
    end.parse!
  end
  def init_request
    uri = URI.parse("#{@url}")
    @response = Net::HTTP.get_response(uri)
  end
end