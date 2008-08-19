module BOSSMan
  class Result < BaseValueObject

    def initialize(response)
      @response = response
      response.each { |key, value| set_parameter(key, value) }
    end

    def to_xml
      @response.to_xml(:root => 'result')
    end

    alias to_s to_xml
    
  end
end