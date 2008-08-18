require 'rubygems'
require 'bossman'

include BOSSMan

BOSSMan.application_id = "xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY"

brooklyn_news = BOSSMan::Search.news("brooklyn new york", 0, 20)

brooklyn_news.results.each do |result|
  puts "#{result.title} [from #{result.source}]"
  puts "-" * 80
  puts "#{result.abstract}"
  puts
end
