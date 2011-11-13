$: << File.join(File.dirname(__FILE__), "/../lib")

require 'rubygems'
require 'uri'
require 'spec'
require 'fakeweb'
require 'bossman'

FakeWeb.allow_net_connect = false

def boss_search(method, query, options = {})
  register_fakeweb(method, query, options)
  BOSSMan::Search.send(method, query, options)
end

def set_boss_api_key
  BOSSMan.application_id = 'fake_key'
end

def register_fakeweb(method, query, options = {})
  uri = boss_url(method, query, options)
  puts "Regging: #{uri}"
  FakeWeb.register_uri(:any, uri, :body => fakeweb_file(method, query))
end

def boss_url(method, query, options = {})
  base_uri = "#{BOSSMan::API_BASEURI}/#{method}/#{BOSSMan::API_VERSION}/#{query}"
  app_id = "appid=#{BOSSMan.application_id}"
  count = options.include?(:count) ? "&count=#{options[:count]}" : "&count=10"
  format = options.include?(:format) ? "&format=#{options[:format]}" : ""
  start = options.include?(:start) ? "&start=#{options[:start]}" : "&start=0"
  view = options.include?(:view) ? "&view=#{options[:view]}" : ""
  query = "#{app_id}#{count}#{format}#{start}#{view}"

  URI.escape("#{base_uri}?#{query}")
end

def fakeweb_file(method, query)
  "#{File.dirname(__FILE__)}/support/fakeweb/#{method}.#{query.gsub(/[ \.]/, "_")}.json"
end