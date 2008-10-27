require 'test/unit'

Dir["#{File.dirname(__FILE__)}/../lib/bossman.rb"].each { |file| require file }

class TestSpelling < Test::Unit::TestCase
  include BOSSMan
  
  def test_spelling
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'

    search = BOSSMan::Search.spelling("titanauic")
    assert_equal(search.responsecode, "200", "Did not receive an HTTP 200 -- received #{search.responsecode}")
    assert_equal(search.suggestion, "titanic", "Spelling suggestion incorrect, expected 'titanic', returned #{search.suggestion}")
  end
end