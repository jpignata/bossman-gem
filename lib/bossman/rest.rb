require 'net/http'
require 'uri'

module BOSSMan
  class REST
        
    def self.get(method, query, options)
      validate_parameters(options)
      uri = URI.parse(URI.encode("#{API_BASEURI}/#{method}/#{API_VERSION}/#{query}"))
      uri.query = options.to_query
      request = Net::HTTP::Get.new(uri.request_uri)
      response = Net::HTTP.new(uri.host).request(request)

      case response
        when Net::HTTPSuccess
          return ResultSet.new(ActiveSupport::JSON.decode(response.body))
        else
          raise BOSSError, parse_error(response.body)
      end 
    end  
    
    def self.parse_error(response_string)
      response_document = REXML::Document.new(response_string)
      error_code = REXML::XPath.first(response_document, '//yahoo:code').text
      error_description = REXML::XPath.first(response_document, '//yahoo:description').text
      error_detail = REXML::XPath.first(response_document, '//yahoo:detail').text
      return "#{error_code} #{error_description}: #{error_detail}"
    end        
    
    def self.validate_parameters(options) 
      unless BOSSMan.application_id
        raise MissingConfiguration, "Application ID must be set prior to making a service call."
      end

      unless options[:count] > 0
        raise InvalidParameter, "Invalid count. Count must be > 0." 
      end
    end
  
  end
end