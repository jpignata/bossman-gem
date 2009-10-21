require File.join(File.dirname(__FILE__), "/spec_helper")

describe "BOSSMan" do
  context "Common Search" do     
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @search = boss_search("web", "wikipedia", :count => 7, :start => 0)
      @result = @search.results.first
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
    
    it "contains a click url for each search result" do
      @result.clickurl.should match(/lrd.yahooapis.com/)
    end

    it "contains the original source url from which each search result was indexed" do
      @result.url.should == "http://www.wikipedia.org/"
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
      @result = boss_search("news", "brooklyn").results.first
    end

    it "contains a description for each result" do
      @result.abstract.should match(/Home values in Brooklyn continued to slide/)
    end

    it "contains a title for each result" do
      @result.title.should == "Brooklyn home values slide, sales up"
    end
    
    it "contains the language each news story is written in" do
      @result.language.should == "english"
    end

    it "contains the date each news story was published" do
      @result.date.should == "2009/10/20"
    end

    it "contains the time each news story was published" do
      @result.time.should == "21:57:34"
    end
    
    it "contains the source from which each news story was indexed" do
      @result.source.should == "New York Post"
    end

    it "contains the source url from which each news story was indexed" do
      @result.sourceurl.should == "http://www.nypost.com/"
    end    
  end

end

