module BOSSMan
  class ResultSet < BaseValueObject
    
    def initialize(response)
      @response = response
      process_response
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
    
    private
      def process_response
        @response["ysearchresponse"].each do |key, value|
          case key
          when "resultset_spell"
            process_spelling_result
          when /resultset/
            process_resultset(key)
          else
            set_parameter(key, value)
          end        
        end
      end
      
      def process_spelling_result
        set_parameter("suggestion", @response["ysearchresponse"]["resultset_spell"].first["suggestion"])
      end
      
      def process_resultset(key)
        results = @response["ysearchresponse"][key].map do |result| 
          Result.new(result) 
        end
        
        set_parameter("results", results)
      end
  end  
end