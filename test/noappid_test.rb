require 'test/unit'

Dir["#{File.dirname(__FILE__)}/../lib/bossman.rb"].each { |file| require file }

class TestNoAppID < Test::Unit::TestCase
  include BOSSMan

  def test_web_search
    BOSSMan.application_id = nil
    
    begin
      BOSSMan::Search.web("Test")
    rescue => e
      assert_match(/must be set/, e.message, "Missing AppID key doesn't result in the valid exception")
    else
      flunk("Missing AppID key doesn't result in an exception")
    end

  end

end