#!/usr/bin/env ruby
require 'net/http'
require 'optparse'
require 'uri'
require_relative 'parser.rb'
require 'colorize'
uri = Parser.new
Parser.treatment(uri.options)
Parser.init_request
Parser.parse(uri.response)
