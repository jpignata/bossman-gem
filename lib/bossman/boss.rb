module BOSSMan
  class BOSS
    HTTP_HEADERS = { 'Accept-Encoding' => 'gzip' }
    
    def initialize(method, query, options)      
      @options = options
      validate_parameters

      @uri = URI.parse(URI.encode("#{API_BASEURI}/#{method}/#{API_VERSION}/#{query}"))
      @uri.query = @options.each { |k,v| "#{URI.encode(k)}=#{URI.encode(v)}" }.join('&')
      @request = Net::HTTP::Get.new(@uri.request_uri, HTTP_HEADERS)
    end
        
    def get
      query_api
      parse_response
    end  

    private
      def query_api
        @response = Net::HTTP.new(@uri.host).request(@request)
      end
        
      def parse_response
        case @response
        when Net::HTTPSuccess
          ResultSet.new(ActiveSupport::JSON.decode(@response.body))
        else
          raise BOSSError, "Error occurred while querying API: #{@response.body}"
        end 
      end
      
      def validate_parameters
        unless BOSSMan.application_id
          raise MissingConfiguration, "Application ID must be set prior to making a service call."
        end

        @options[:count] = 10 unless @options.include?(:count) && @options[:count] > 0
      end      
  end
end
