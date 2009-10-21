$: << File.join(File.dirname(__FILE__), "/../lib")

require 'spec'
require 'fakeweb'
require 'bossman'

FakeWeb.allow_net_connect = false

def boss_search(method, query, options = {})
  register_fakeweb(method, query, options)
  BOSSMan::Search.send(method, query, options)
end

def set_boss_api_key
  BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
end

def register_fakeweb(method, query, options = {})
  uri = boss_url(method, query, options)
  FakeWeb.register_uri(:any, uri, :body => "#{File.dirname(__FILE__)}/support/fakeweb/#{method}.#{query}.json")
end

def boss_url(method, query, options = {})
  base_uri = "#{BOSSMan::API_BASEURI}/#{method}/#{BOSSMan::API_VERSION}/#{query}"
  app_id = "appid=#{BOSSMan.application_id}"
  count = options.include?(:count) ? "count=#{options[:count]}" : "count=10"
  start = options.include?(:start) ? "start=#{options[:start]}" : "start=0"
  query = "?#{app_id}&#{count}&#{start}"  

  base_uri + query
end