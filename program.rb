# frozen_string_literal: true

## Main program file
# Please run in console as:
# > ruby program.rb --file Input.csv --years 1877,1878 --teams "Providence Grays"
# or
# > ruby program.rb -f Input.csv -y 1877 -t "Louisville Grays"
#
# Note: filters (--years & --teams) are optional, however input file (--file) is required!

require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'optparse'
  gem 'hirb'
  gem 'pry'
end
require 'optparse'
require 'hirb'
require './csv_import'
require './batting'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: program.rb [options]'

  opts.on('-f file', '--file file', 'Input file') do |file|
    options[:file] = file
  end

  opts.on('-y years', '--years years', 'Filter years') do |years|
    options[:years] = years
  end

  opts.on('-t teams', '--teams teams', 'Filter teams') do |teams|
    options[:teams] = teams
  end
end.parse!

import = CsvImport.new options
result = Batting.new import.read
result.process
result.display
