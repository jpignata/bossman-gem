require 'rubygems'
require 'bossman'

include BOSSMan

APP_ID = "" #Replace with an actual YDN application ID
BOSSMan.application_id = APP_ID 

dumbo_images = BOSSMan::Search.images("brooklyn dumbo", 0, 2)

dumbo_images.results.each do |result|
  puts "<img src=\"#{result.url}\" alt=\"#{result.abstract}\" /><br />"
end