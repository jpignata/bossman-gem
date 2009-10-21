module BOSSMan
  class ResultSet < BaseValueObject
    
    def initialize(response)
      @response = response

      @response["ysearchresponse"].each do |key, value|
        if key.include? "resultset_spell"
          set_parameter("suggestion", @response["ysearchresponse"]["resultset_spell"][0]["suggestion"])
        elsif key.include? "resultset"
          results = Array.new
          response["ysearchresponse"][key].each { |result| 
            begin
              result = Result.new(result) 
            rescue
              next
            else
              results << result
            end
          }
          set_parameter("results", results)
        else
          set_parameter(key, value)
        end        
      end
    end
              
    def to_xml
      @response['ysearchresponse'].to_xml(:root => 'resultset')
    end
    
    def _dump(level)
      @response.to_json
    end
    
    def self._load(string)
      ResultSet.new(ActiveSupport::JSON.decode(string))
    end
    
    alias to_s to_xml
  end  
end