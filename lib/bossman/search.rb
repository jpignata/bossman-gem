module BOSSMan
  class Search 
    class << self

      def web(query, start=0, count=10, filter=nil, type=nil, lang=nil, region=nil)    
        method = "web"

        options = default_options(BOSSMan.application_id, count, start)
        options[:filter] = filter if filter
        options[:type] = type if type
        options[:lang] = lang if lang
        options[:region] = region if region

        return REST.get(method, query, options)
      end

      def images(query, start=0, count=10, filter=nil, dimensions=nil, refererurl=nil, url=nil)
        method = "images"

        options = default_options(BOSSMan.application_id, count, start)
        options[:filter] = filter if filter
        options[:dimensions] = dimensions if dimensions
        options[:refererurl] = refererurl if refererurl
        options[:url] = url if url

        return REST.get(method, query, options)
      end

      def news(query, start=0, count=10, age=nil)
        method = "news"

        options = default_options(BOSSMan.application_id, count, start)
        options[:age] = age if age

        return REST.get(method, query, options)
      end

      private    
      def default_options(appid, count, start)
        return {:appid => appid, :count => count, :start => start}
      end

    end
  end
end