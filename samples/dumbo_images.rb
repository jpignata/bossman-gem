require 'rubygems'
require 'bossman'

include BOSSMan

APP_ID = "" #Replace with an actual YDN application ID
BOSSMan.application_id = APP_ID 

boss = BOSSMan::Search.images("brooklyn dumbo", { :dimensions => 'large' })

boss.results.each do |result|
  puts "<img src=\"#{result.url}\" alt=\"#{result.abstract}\" /><br />"
end
