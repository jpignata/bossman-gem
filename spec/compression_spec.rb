require File.join(File.dirname(__FILE__), "/spec_helper")

describe "HTTPSuccess" do
  describe ".body" do
    it "returns a plain text body if no compression is used in the response" do
      uri = URI.parse("http://www.example.com")
      FakeWeb.register_uri(:any, uri, :body => "#{File.dirname(__FILE__)}/support/fakeweb/www.example.com")

      request = Net::HTTP::Get.new(uri.request_uri)
      response = Net::HTTP.new(uri.host).request(request)
      response.body.should match(/These domain names are reserved for use in documentation/)
    end

    it "returns a plain text body if gzip is used in the response" do
      uri = URI.parse("http://www.example.com")
      FakeWeb.register_uri(:any, uri, :body => "#{File.dirname(__FILE__)}/support/fakeweb/www.example.com.gz", 'content-encoding' => 'gzip')

      request = Net::HTTP::Get.new(uri.request_uri)
      response = Net::HTTP.new(uri.host).request(request)
      response.body.should match(/These domain names are reserved for use in documentation/)
    end
  end
end