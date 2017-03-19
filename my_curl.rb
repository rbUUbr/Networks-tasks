require 'net/http'
require 'uri'
require_relative 'parse_methods.rb'
require 'colorize'
include Parser
uri = URI.parse("#{ARGV[0]}")
response = Net::HTTP.get_response(uri)
is_correct?(response)
if !(response.code =~ /2[0-9][0-9]/)
  puts "Error!, code of error is: #{response.code}\n".color(:red)
else
  puts "All is correct, code is #{response.code}\n".colorize(:green)
  puts "#{response.body}".colorize(:blue)
end
