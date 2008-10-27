require 'test/unit'

Dir["#{File.dirname(__FILE__)}/../lib/bossman.rb"].each { |file| require file }

class TestBadKey < Test::Unit::TestCase
  include BOSSMan

  def test_web_search
    BOSSMan.application_id = 'Fakester'

    begin
      BOSSMan::Search.web("Test")
    rescue => e
      assert_match(/Invalid bbAuth AppID/, e.message, "Bad AppID key doesn't result in the valid exception")
    else
      flunk("Bad AppID key doesn't result in an exception")
    end

  end

end