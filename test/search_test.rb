require 'test/unit'

Dir["#{File.dirname(__FILE__)}/../lib/bossman.rb"].each { |file| require file }

class TestWeb < Test::Unit::TestCase
  include BOSSMan
  
  def test_wikipedia
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.web('"wikipedia"', { :count => 7 } )
    assert_equal search.count, "7"
    assert_equal search.results[0].abstract, "<b>Wikipedia</b> is a free, open content, community-built encyclopedia with thousands of articles on topics from A to Z. Available in dozens of languages."
  end

  def test_wikipedia_brokencase
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search= BOSSMan::Search.web('"wikipedia is better than *"', { :filter => "-porn" })
    assert_equal search.responsecode, "200"
    assert_instance_of(BOSSMan::Result, search.results[0], "Result not an instance of BOSSMan::Result")
  end
  
  def test_news_search
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.news('"brooklyn"', { :count => 7 } )
    assert_equal(search.count, "7", "News search did not return the correct number of results.")
  end
  
  def test_news_search
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.images('"bridge"', { :count => 7 } )
    assert_equal(search.count, "7", "Image search did not return the correct number of results.")
  end
  
  def test_yaml_output
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.web("Revolution Health")
    assert_match(/ysearchresponse:/, search.to_yaml, "to_yaml not returning proper YAML")
  end
  
  def test_json_output
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.web("Revolution Health")
    assert_match(/\{"ysearchresponse":/, search.to_json, "to_json not returning proper JSON")
  end
  
  def test_resultset_toxml
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.web("Revolution Health")
    assert_match(/\<resultset-web\>/, search.to_xml, "Resultset to xml did not return XML")
  end

  def test_result_toxml
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.web("Revolution Health")
    assert_match(/\<title\>/, search.results[0].to_xml, "Resultset to xml did not return XML")
  end
end
