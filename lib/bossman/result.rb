module BOSSMan
  class Result < BaseValueObject

    def initialize(results)
      results.each { |key, value| set_parameter(key, value) }
    end

  end
end