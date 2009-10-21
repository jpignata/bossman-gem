module BOSSMan
  class Search 
    DEFAULT_COUNT = 10
    DEFAULT_START = 0

    class << self
      def method_missing(*args)
        method, query, options = args
        super unless [:web, :images, :news, :spelling].include?(method)
        options = {} if options.nil?
        boss = BOSS.new(method, query, options_defaults.merge!(options))
        boss.get
      end
    end

    private
      def self.options_defaults
        {:appid => BOSSMan.application_id, :count => DEFAULT_COUNT, :start => DEFAULT_START }
      end
  end
end