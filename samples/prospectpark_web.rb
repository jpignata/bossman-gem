require 'rubygems'
require 'bossman'

include BOSSMan

BOSSMan.application_id = "xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY"

prospectpark_web = BOSSMan::Search.web("prospect park", 0, 20)

puts "Number of results: #{prospectpark_web.totalhits}"
puts

prospectpark_web.results.each do |result|
  puts "#{result.title}"
  puts "-" * 80
  puts "#{result.abstract}"
  puts
end
