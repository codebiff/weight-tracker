require "rspec"
require "rack/test"

ENV['RACK_ENV'] = 'test'

describe "Application" do
	include Rack::Test::Methods

	def app 
		Rack::Builder.parse_file(File.dirname(__FILE__) + "/../config.ru").first
	end

	it "should get the home page" do
		get "/"
		last_response.should be_ok
	end

	it "should not be able to find a fake path" do
		get "/completelymadeuproute"
		last_response.should_not be_ok
	end

end