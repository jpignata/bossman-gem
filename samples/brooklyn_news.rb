require '../lib/bossman.rb'
include BOSSMan

application_id "xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY"

news_search("brooklyn", 0, 500, "1d")["resultset_news"].each {|article|
  puts article["title"]
}
