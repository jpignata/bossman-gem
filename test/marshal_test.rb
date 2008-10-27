require 'test/unit'

Dir["#{File.dirname(__FILE__)}/../lib/bossman.rb"].each { |file| require file }

class MarshalCount < Test::Unit::TestCase
  include BOSSMan
  
  def test_dump
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.web("RevolutionHealth")
    dump = search._dump(nil)
    assert_match(/\{"ysearchresponse":/, dump, "ResultSet._dump() method is not returning JSON")
  end

  def test_load
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'
    search = BOSSMan::Search.web("RevolutionHealth")
    dump = search._dump(nil)
    result = BOSSMan::ResultSet._load(dump)
    assert_equal(result.responsecode, "200", "Could not load JSON to create new ResultSet")
  end

end