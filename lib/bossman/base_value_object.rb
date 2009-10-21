module BOSSMan
  class BaseValueObject
      def set_parameter(key, value)
        instance_variable_set("@#{key}", value) 
      end
      
      def to_yaml
        @response.to_yaml
      end

      def to_json
        ActiveSupport::JSON.encode(@response)
      end
      
      def method_missing(*args)
        method = args.first
        instance_variable_get("@#{method}")
      end
  end 
end