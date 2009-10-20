require 'active_support'

Dir["#{File.dirname(__FILE__)}/bossman/*.rb"].sort.each { |bossman_lib| require bossman_lib }

module BOSSMan
  API_VERSION = :v1
  API_BASEURI = "http://boss.yahooapis.com/ysearch"
  
  %w( application_id proxy_host proxy_port proxy_user proxy_pass ).each do |att|
    attr_accessor att.to_sym
    module_function att.to_sym, "#{att}=".to_sym
  end

  class MissingConfiguration < StandardError; end
  class InvalidParameter < StandardError; end
  class BOSSError < StandardError; end
end
