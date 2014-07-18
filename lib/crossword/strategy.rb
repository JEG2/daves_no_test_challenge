module Crossword
  class Strategy
    def self.strategies
      @strategies ||= [ ]
    end

    def self.inherited(subclass)
      strategies << subclass
    end

    def self.load(dir = File.join(__dir__, "strategies"))
      Dir.glob("#{dir}/*.rb") do |path|
        Kernel.load path
      end
    end

    def self.match(clue)
      strategies.each do |subclass|
        strategy = subclass.new(clue)
        return strategy if strategy.match?
      end
      nil
    end

    def initialize(clue)
      @clue       = clue
      @match_data = nil
    end

    attr_reader :clue, :match_data
    private     :clue, :match_data

    def match?
      @match_data = self.class.const_get(:CLUE_REGEX).match(clue)
    end

    def answer
      fail NotImplementedError, "Strategies must override answer()"
    end
  end
end
