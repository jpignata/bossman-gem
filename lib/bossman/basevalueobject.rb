module BOSSMan
  class BaseValueObject

      def set_parameter(key, value)
        instance_variable_set("@#{key}", value) 
        instance_eval("def #{key}; @#{key}; end")
      end
      
      def to_yaml
        @response.to_yaml
      end

      def to_json
        ActiveSupport::JSON.encode(@response)
      end
      
  end 
end