module BOSSMan
  class Search 
    class << self
      DEFAULT_COUNT = 10
      DEFAULT_START = 0
      
      def web(query, options = {})    
        method = "web"
        options.merge!(return_options(options))
        return REST.get(method, query, options)
      end

      def images(query, options = {})
        method = "images"
        options.merge!(return_options(options))        
        return REST.get(method, query, options)
      end

      def news(query, options = {})
        method = "news"
        options.merge!(return_options(options))
        return REST.get(method, query, options)
      end

      def spelling(query, options = {})
        method = "spelling"
        options.merge!(return_options(options))
        return REST.get(method, query, options)
      end
      
      private
      def return_options(options)
        count = options[:count] ? options[:count] : DEFAULT_COUNT
        start = options[:start] ? options[:start] : DEFAULT_START
        return {:appid => BOSSMan.application_id, :count => count, :start => start }
      end

    end
  end
end