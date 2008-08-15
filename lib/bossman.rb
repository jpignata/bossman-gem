require 'net/http'
require 'uri'
require 'rubygems'
require 'active_support'
require 'rexml/xpath'
require 'rexml/document'

module BOSSMan
  VERSION = :v1
  BASE_URI = "http://boss.yahooapis.com/ysearch"
  
  def application_id(application_id=nil)
    return @application_id unless application_id
    @application_id = application_id
  end
      
  def web_search(query, start=0, count=10, filter=nil, type=nil, lang=nil, region=nil)    
    method = "web"
    
    validate_parameters(count)
    
    options = { 
      :appid => application_id,
      :count => count,
      :start => start
    }
    
    options[:filter] = filter if filter
    options[:type] = type if type
    options[:lang] = lang if lang
    options[:region] = region if region
    
    get_from_boss(method, query, options)
  end
  
  def images_search(query, start=0, count=10, filter=nil, dimensions=nil, refererurl=nil, url=nil)
    method = "images"

    validate_parameters(count)
    
    options = { 
      :appid => application_id,
      :count => count,
      :start => start
    }

    options[:filter] = filter if filter
    options[:dimensions] = dimensions if dimensions
    options[:refererurl] = refererurl if refererurl
    options[:url] = url if url

    get_from_boss(method, query, options)
  end
  
  def news_search(query, start=0, count=10, age=nil)
    method = "news"
    
    validate_parameters(count)
    
    options = { 
      :appid => application_id,
      :count => count,
      :start => start
    }

    options[:age] = age if age
    
    get_from_boss(method, query, options)
  end
  
  private
  def get_from_boss(method, query, options)
    uri = URI.parse("#{BASE_URI}/#{method}/#{VERSION}/#{query}")
    uri.query = options.to_query

    request = Net::HTTP::Get.new(uri.request_uri)
    response = Net::HTTP.new(uri.host).request(request)
    
    case response
      when Net::HTTPSuccess
        return ActiveSupport::JSON.decode(response.body)["ysearchresponse"]        
      else
        raise BOSSError, parse_error(response.body)
    end
  end
  
  def parse_error(response_string)
    response_document = REXML::Document.new(response_string)
    code = REXML::XPath.first(response_document, '//yahoo:code').text
    description = REXML::XPath.first(response_document, '//yahoo:description').text
    detail = REXML::XPath.first(response_document, '//yahoo:detail').text
    return "#{code} #{description}: #{detail}"
  end
  
  def validate_parameters(count) 
    unless @application_id
      raise MissingConfiguration, "Application ID must be set prior to making a service call."
    end
  
    unless count > 0 
      raise InvalidParameter, "Invalid count. Count must be > 0." 
    end
  end
  
  class MissingConfiguration < StandardError; end
  class InvalidParameter < StandardError; end
  class BOSSError < StandardError; end
  
end