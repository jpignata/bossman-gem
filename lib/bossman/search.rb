module BOSSMan
  class Search 
    DEFAULT_COUNT = 10
    DEFAULT_START = 0

    class << self
      def method_missing(*args)
        method, query, options = args
        super unless [:web, :images, :news, :spelling].include?(method)
        options.merge!(merge_options_with_defaults(options))
        REST.get(method, query, options)
      end
      
      private
        def merge_options_with_defaults(options)
          count = options[:count] ? options[:count] : DEFAULT_COUNT
          start = options[:start] ? options[:start] : DEFAULT_START
          {:appid => BOSSMan.application_id, :count => count, :start => start }
        end
    end
  end
end