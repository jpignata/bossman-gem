require 'rubygems'
require 'bossman'

include BOSSMan

APP_ID = "" #Replace with an actual YDN application ID
BOSSMan.application_id = APP_ID 

brooklyn_news = BOSSMan::Search.news("brooklyn new york", 0, 20)

brooklyn_news.results.each do |result|
  puts "#{result.title} [from #{result.source}]"
  puts "-" * 80
  puts "#{result.abstract}"
  puts
end
