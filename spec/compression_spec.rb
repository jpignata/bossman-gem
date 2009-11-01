require File.join(File.dirname(__FILE__), "/spec_helper")

describe "HTTPSuccess" do
  describe ".body" do
    def do_request
      request = Net::HTTP::Get.new(@uri.request_uri)
      response = Net::HTTP.new(@uri.host).request(request)
      response.body.should match(/These domain names are reserved for use in documentation/)
    end

    before do
      @uri = URI.parse("http://www.example.com")
    end

    it "returns a plain text body if no compression is used in the response" do
      options = { :body => "#{File.dirname(__FILE__)}/support/fakeweb/www.example.com" }
      FakeWeb.register_uri(:any, @uri, options)
      do_request
    end

    it "returns a plain text body if gzip is used in the response" do
      options = { 
        :body => "#{File.dirname(__FILE__)}/support/fakeweb/www.example.com.gz", 
        'Content-Encoding' => :gzip
      }
      FakeWeb.register_uri(:any, @uri, options)
      do_request
    end
  end
end