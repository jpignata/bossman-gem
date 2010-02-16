module BOSSMan
  class ResultSet < BaseValueObject
    
    def initialize(response)
      @response = response
      @ysearchresponse = response["ysearchresponse"] || response # JSON uses ysearchresponse, XML not
      process_response
    end
              
    def to_xml
      @ysearchresponse.to_xml(:root => "resultset")
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
        @ysearchresponse.each do |key, value|
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
        suggestion = @ysearchresponse["resultset_spell"].first["suggestion"]
        set_parameter("suggestion", suggestion)
      end
      
      def process_resultset(key)
        if @ysearchresponse[key].is_a?(Array)
          # JSON
          resultset =  @ysearchresponse[key]
          results = resultset.map { |result| Result.new(result) }
          set_parameter("results", results)
        else
          resultset = @ysearchresponse[key]['result'] # XML puts them inside 'result'
          results = resultset.map { |result| Result.new(result) }
          set_parameter("results", results)
          set_parameter("count", @ysearchresponse[key]['count'])
          set_parameter("deephits", @ysearchresponse[key]['deephits'])
          set_parameter("totalhits", @ysearchresponse[key]['totalhits'])
          set_parameter("start", @ysearchresponse[key]['start'])
        end
      end
  end  
end