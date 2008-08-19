require 'rubygems'
require 'bossman'

include BOSSMan

APP_ID = "" #Replace with an actual YDN application ID
BOSSMan.application_id = APP_ID 

prospectpark_web = BOSSMan::Search.web("prospect park", 0, 20)

puts "Number of results: #{prospectpark_web.totalhits}"
puts

prospectpark_web.results.each do |result|
  puts "#{result.title}"
  puts "-" * 80
  puts "#{result.abstract}"
  puts
end
