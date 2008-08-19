require 'rubygems'
require 'active_support'

Dir["#{File.dirname(__FILE__)}/bossman/*.rb"].each { |bossman_lib| require bossman_lib }

module BOSSMan
  API_VERSION = :v1
  API_BASEURI = "http://boss.yahooapis.com/ysearch"

  attr_accessor :application_id

  class MissingConfiguration < StandardError; end
  class InvalidParameter < StandardError; end
  class BOSSError < StandardError; end
end