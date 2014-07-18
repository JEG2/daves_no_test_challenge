require "csv"
require "time"

require_relative "name"

module Crossword
  class PresidentList
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

    def initialize(path = File.join(__dir__, *%w[.. .. data presidents.csv]))
      @presidents = CSV.read(
        path,
        headers:           true,
        header_converters: :symbol,
        converters:        lambda { |field, field_info|
          if field_info.header == :president
            Name.new(field.sub(" (2nd term)", ""))
          elsif %i[took_office left_office].include?(field_info.header)
            Time.strptime(field.sub("Incumbent", "20/01/2017"), "%d/%m/%Y")
          else
            field
          end
        }

      )
    end

    attr_reader :presidents
    private     :presidents

    def find_by_name(name)
      presidents.find { |record| record[:president] == name }
    end

    def find_by_number(number)
      presidents.find { |record| record[:presidency] == number }
    end

    def find_by_year(year)
      matches = presidents.select { |record|
        record[:took_office].year <= year && year <= record[:left_office].year
      }
      if matches.size == 1
        matches.first
      else
        fail "Ambiguous year:  #{year}"
      end
    end
  end
end
