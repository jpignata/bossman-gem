require '../lib/bossman.rb'

include BOSSMan

BOSSMan.application_id = "xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY"

dumbo_images = BOSSMan::Search.images("brooklyn dumbo", 0, 2)

dumbo_images.results.each do |result|
  puts "<img src=\"#{result.url}\" alt=\"#{result.abstract}\" /><br />"
end