require 'spec_helper.rb'

describe "BOSSMan" do
  context "Common Search" do     
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @search = boss_search("web", "wikipedia", :count => 7, :start => 0)
    end
    
    it "contains the HTTP response code" do
      @search.responsecode.should == "200"
    end

    it "contains the URL to the next page of search results" do
      @search.nextpage.should == "/ysearch/web/v1/%22wikipedia%22?format=json&count=7&appid=#{BOSSMan.application_id}&start=7"
    end

    it "contains the count of results returned in the search" do
      @search.count.should == @search.results.length.to_s
    end

    it "contains the number of the first search result requests" do
      @search.start.should == "0"
    end
    
    it "contains the number of total hits returned in the search" do
      @search.totalhits.should == "36434588"
      @search.deephits.should == "1070000000"
    end

    it "contains a collection of search results" do
      @search.results.should be_an_instance_of(Array)
    end  
  end
  
  context "Spelling Suggestion" do
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @search = boss_search("spelling", "diaberties")
    end

    it "returns one spelling suggestion" do
      @search.suggestion.should == "diabetes"
    end
  end
  
  context "News Search" do
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @search = boss_search("spelling", "diaberties")
    end
  end

end

