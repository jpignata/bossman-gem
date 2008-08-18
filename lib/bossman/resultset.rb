module BOSSMan
  class ResultSet < BaseValueObject

    def initialize(response)      
      response["ysearchresponse"].each do |key, value|
        if key.include? "resultset"
          results = Array.new
          response["ysearchresponse"][key].each { |result| results << Result.new(result) }
          set_parameter("results", results)
        else
          set_parameter(key, value)
        end        
      end
    end

  end  
end