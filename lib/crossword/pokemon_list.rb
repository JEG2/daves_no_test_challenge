require "csv"

module Crossword
  class PokemonList
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

    def initialize(path = File.join(__dir__, *%w[.. .. data pokemon.csv]))
      @pokemon = CSV.read(path, headers: true, header_converters: :symbol)
    end

    attr_reader :pokemon
    private     :pokemon

    def find_by_number(number)
      pokemon.find { |record| record[:id] == number }
    end

    def find_by_name(name)
      pokemon.find { |record| record[:identifier] == name }
    end
  end
end
