$: << File.join(File.dirname(__FILE__))

# Added to parse XML
# require 'active_resource' 
require 'xmlsimple'

require 'active_support'
require 'net/http'
require 'uri'

require 'extensions/net/http_success'

require 'bossman/base_value_object'
require 'bossman/boss'
require 'bossman/result_set'
require 'bossman/result'
require 'bossman/search'

module BOSSMan
  API_VERSION = :v1
  API_BASEURI = "http://boss.yahooapis.com/ysearch"

  attr_accessor :application_id
  module_function :application_id, :application_id=

  class MissingConfiguration < StandardError; end
  class BOSSError < StandardError; end
end