require 'optparse'
load "./parse_methods.rb"
class Parser
  include ParseMethods
  attr_accessor :response, :data, :url, :ssl, :username, :password, :type_of_inputs, :isneed_user_input, :file
  def initialize(dt = {}, url_without_parse = '', resp ={}, check = false, usrname = '', pswd = '', usr_input = false, type = "puts", file = "")
    @data = dt
    @url = url_without_parse
    @response = resp
    @ssl = false
    @username = usrname
    @password = pswd
    @isneed_user_input = usr_input
    @file = file
  end
  def open_file(parser)
    parser.on("-f=f", "--file=f", "Write results also to file".colorize(:light_blue)) do |f|
      $stdout = File.open(f, "w+")
    end
  end
  def auth(parser)
    parser.on("-a", "--auth", "Settings the username for authorization".colorize(:light_blue)) do ||
      @isneed_user_input = true
    end
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
  def init_request_with_user_info
    input_user_info
    uri = URI.parse(@url)
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(@username, @password)
    req_options = {
        use_ssl: uri.scheme == "https",
    }
    @response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
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
      output_parsed_page
    end
  end
  def output_parsed_page
    if !(@response.code =~ /2[0-9][0-9]/)
      send(:puts, "Error! code of error is: #{@response.code}\n".colorize(:red))
    else
      send(:puts, "All is correct, code is #{@response.code}\n".colorize(:green))
      send(:puts, "#{@response.body}".colorize(:light_blue))
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
    @url = ''
    OptionParser.new do |parser|
      help(parser)
      auth(parser)
      make_ssl_connection(parser)
      parse_page(parser)
      post_data_to_site(parser)
      open_file(parser)
    end.parse!
  end
  def init_request_without_ssl
    uri = URI.parse("#{@url}")
    @response = Net::HTTP.get_response(uri)
  end
  def init_request_with_ssl
    uri = URI.parse(@url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    @response = http.request(request)
  end
  def init_request
    if @isneed_user_input
      init_request_with_user_info
      return
    end
    if @ssl
      init_request_with_ssl
    else
      init_request_without_ssl
    end
  end
end