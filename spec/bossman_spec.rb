require File.join(File.dirname(__FILE__), "/spec_helper")

describe "BOSSMan" do
  context "Search results" do     
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
    
    it "contains a click URL for each search result" do
      @result.clickurl.should match(/lrd.yahooapis.com/)
    end

    it "contains the original source URL from which each search result was indexed" do
      @result.url.should == "http://www.wikipedia.org/"
    end

    it "can be returned as a YAML document" do
      YAML.load(@search.to_yaml)["ysearchresponse"].should be_an_instance_of(Hash)
    end

    it "can be returned as a JSON document" do
      ActiveSupport::JSON.decode(@search.to_json)["ysearchresponse"].should be_an_instance_of(Hash)
    end     
  end

  context "Search results in XML" do     
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @search = boss_search("web", "yelp", :view => "searchmonkey_rdf", :format => 'xml', :count => 5, :start => 0)
      @result = @search.results.first
    end
    
    it "contains the HTTP response code" do
      @search.responsecode.should == "200"
    end

    it "contains the count of results returned in the search" do
      @search.count.should == @search.results.length.to_s
    end

    it "contains SearchMonkey RDF for second result" do
      @search.results[1].searchmonkey_rdf.should_not == {}
      @search.results[1].searchmonkey_rdf.should_not == "Search monkey data not supported in JSON"
    end

    it "contains no SearchMonkey RDF for first result" do
      @search.results[0].searchmonkey_rdf.should == {}
    end

    it "contains the number of total hits returned in the search" do
      @search.totalhits.should == "19868"
      @search.deephits.should == "178000"
    end

    it "contains the number of the first search result requests" do
      @search.start.should == "0"
    end

    it "contains the URL to the next page of search results" do
      @search.nextpage.should == "/ysearch/web/v1/restaurant%20cinnamon%20yelp?format=xml&filter=-hate&count=5&appid=#{BOSSMan.application_id}&view=searchmonkey_rdf&start=5"
    end

  end
  
  context "Spelling suggestion search" do
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @search = boss_search("spelling", "diaberties")
    end

    it "returns one spelling suggestion" do
      @search.suggestion.should == "diabetes"
    end
  end
  
  context "News search" do
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

    it "contains the source URL from which each news story was indexed" do
      @result.sourceurl.should == "http://www.nypost.com/"
    end    
  end
  
  context "Web search" do
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @result = boss_search("web", "apollo 11").results[1]
    end

    it "contains a description for each result" do
      @result.abstract.should match(/Hyperlinked article about the first manned lunar landing/)
    end

    it "contains a title for each result" do
      @result.title.should == "<b>Apollo</b> <b>11</b> - Wikipedia"
    end

    it "contains a display URL for each result" do
      @result.dispurl.should == "<b>en.wikipedia.org</b>/wiki/<wbr><b>Apollo</b>_<b>11</b>"
    end

    it "contains the size for each result" do
      @result.size.should == "183978"
    end

    it "contains the date each result was last indexed" do
      @result.date.should == "2009/10/19"
    end
  end
  
  context "Inlink search" do
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @result = boss_search("se_inlink", "www.rubyonrails.org").results[2]
    end
  
    it "contains a description of each site linking to the site in the query" do
      @result.abstract.should match(/Personal weblog for David Heinemeier Hansson/)
    end
    
    it "contains a click URL for each site linking to the site in the query" do
      @result.clickurl.should match(/lrd.yahooapis.com/)
    end

    it "contains a URL for each site linking to the site in the query" do
      @result.url.should == "http://www.loudthinking.com/"
    end
    
    it "contains a title for each site linking to the site in the query" do
      @result.title.should == "Loud Thinking by David Heinemeier Hansson"
    end
  end

  context "Page data search" do
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @result = boss_search("se_pagedata", "www.wnyc.org").results.last
    end
  
    it "contains a description of each site linking to the site in the query" do
      @result.abstract.should match(/The Brian Lehrer Show/)
    end
    
    it "contains a click URL for each site linking to the site in the query" do
      @result.clickurl.should match(/lrd.yahooapis.com/)
    end

    it "contains a URL for each site linking to the site in the query" do
      @result.url.should == "http://www.wnyc.org/shows/radiolab/episodes/2008/11/14"
    end
    
    it "contains a title for each site linking to the site in the query" do
      @result.title.should == "WNYC - Radiolab: Choice (November 14, 2008)"
    end
  end
  
  context "Image search" do
    before(:all) do
      include BOSSMan
      set_boss_api_key
      @result = boss_search("images", "brooklyn bridge").results[1]
    end

    it "contains a description for each result" do
      @result.abstract.should == "Puzzles NYC Brooklyn Bridge and Manhattan 2000 Pc Jigsaw $28 00"
    end

    it "contains the original filename of each result" do
      @result.filename.should == "puzzles 2000pc brooklyn bridge jpg"
    end

    it "contains the size for each result" do
      @result.size.should == "19900"
    end

    it "contains the format for each result" do
      @result.format.should == "jpeg"
    end

    it "contains the height for each result" do
      @result.height.should == "162"
    end
    
    it "contains the date each result was last indexed" do
      @result.date.should == "2006/10/14"
    end

    it "contains the MIME type for each result" do
      @result.mimetype.should == "image/jpeg"
    end

    it "contains the referrer click URL for each result" do
      @result.refererclickurl.should match(/lrd.yahooapis.com/)
    end

    it "contains the referrer URL for each result" do
      @result.refererurl.should == "http://www.terrifictoy.com/store/2000pc_jigsaws_brooklyn_bridge.html"
    end
    
    it "contains the title of each result" do
      @result.title.should == "puzzles 2000pc brooklyn bridge jpg"
    end
    
    it "contains the width for each result" do
      @result.width.should == "216"
    end
    
    it "contains a thumbnail image URL for each result" do
      @result.thumbnail_url.should == "http://thm-a02.yimg.com/image/2d612d7be1869b48"
    end

    it "contains a thumbnail image height for each result" do
      @result.thumbnail_height.should == "97"
    end

    it "contains a thumbnail image width for each result" do
      @result.thumbnail_width.should == "130"
    end
          
  end
end

