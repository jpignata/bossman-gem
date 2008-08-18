module BOSSMan
  class BaseValueObject

      def set_parameter(key, value)
        instance_variable_set("@#{key}", value) 
        instance_eval("def #{key}; @#{key}; end")
      end

  end 
end