require "json"

module Crossword
  class ElementList
    def self.loaded
      @loaded ||= new
    end

    def self.method_missing(method, *args, &block)
      if loaded.respond_to?(method)
        loaded.send(method, *args, &block)
      else
        super
      end
    end

    def initialize(path = File.join(__dir__, *%w[.. .. data elements.json]))
      @elements = JSON.parse(File.read(path))
    end

    attr_reader :elements
    private     :elements

    def find_by_number(number)
      elements.find { |_, details| details["atomic_number"] == number }
    end

    def find_by_symbol(symbol)
      elements.find { |_, details| details["symbol"] == symbol }
    end
  end
end
