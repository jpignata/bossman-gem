require 'rubygems'
require 'active_support'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'bossman/search'
require 'bossman/rest'
require 'bossman/basevalueobject'
require 'bossman/resultset'
require 'bossman/result'

module BOSSMan
  API_VERSION = :v1
  API_BASEURI = "http://boss.yahooapis.com/ysearch"

  attr_accessor :application_id

  class MissingConfiguration < StandardError; end
  class InvalidParameter < StandardError; end
  class BOSSError < StandardError; end
end