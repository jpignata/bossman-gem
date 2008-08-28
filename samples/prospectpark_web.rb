require 'rubygems'
require 'bossman'

include BOSSMan

APP_ID = "" #Replace with an actual YDN application ID
BOSSMan.application_id = APP_ID

boss = BOSSMan::Search.web("prospect park", {:count => 1 })

puts "Number of results: #{boss.totalhits}"
puts

boss.results.each do |result|
  puts "#{result.title}"
  puts "-" * 80
  puts "#{result.abstract}"
  puts
end
