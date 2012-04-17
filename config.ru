$:.unshift File.dirname(__FILE__)

require "sinatra/base"
require "sass"
require "coffee_script"

# Google Analytics
#require "rack/google-analytics"
#use Rack::GoogleAnalytics, :tracker => "UA-28186072-1"

# Monkey pathes
require "./lib/fixnum"
require "./lib/weight_converter"

# The App
require "settings"
require "models"
require "helpers"
require "routes"
run Application
