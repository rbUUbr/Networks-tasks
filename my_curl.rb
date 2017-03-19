#!/usr/bin/env ruby
require 'net/http'
require 'optparse'
require 'uri'
require_relative 'parse_methods.rb'
require 'colorize'
include Parser
options = {}
#uri = URI.parse("#{ARGV[0]}")
#response = Net::HTTP.get_response(uri)
#is_correct?(response)
switch_for_first_param
