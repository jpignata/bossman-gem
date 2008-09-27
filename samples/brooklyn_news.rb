require 'rubygems'
require 'bossman'

include BOSSMan

APP_ID = "xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY" #Replace with an actual YDN application ID
BOSSMan.application_id = APP_ID 

boss = BOSSMan::Search.news("brooklyn new york", { :count => 1, :age => '7d' })

boss.results.each do |result|
  puts "#{result.title} [from #{result.source}]"
  puts "-" * 80
  puts "#{result.abstract}"
  puts
end
