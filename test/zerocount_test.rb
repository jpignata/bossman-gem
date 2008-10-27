require 'test/unit'

Dir["#{File.dirname(__FILE__)}/../lib/bossman.rb"].each { |file| require file }

class TestZeroCount < Test::Unit::TestCase
  include BOSSMan
  
  def test_zero_count
    BOSSMan.application_id = 'xXySTCfV34HiWg67Cwwym2mvf4tUfLJS3B73thD5ws_xFbLYh6uVvNJmBZDDCoByFRIY'

    begin
      BOSSMan::Search.web("RevolutionHealth", { :count => 0 })
    rescue => e
      assert_match(/Invalid count/, e.message, "Zero count did not yield appropriate count exception")
    else
      flunk("Zero count doesn't result in an exception")
    end
  end
end