#!/usr/bin/env ruby
require 'net/http'
require 'net/https'
require 'optparse'
require 'uri'
require_relative 'parser.rb'
require 'colorize'
uri = Parser.new
uri.treatment
