require_relative "board"
require_relative "strategy"

module Crossword
  class Solver
    def initialize(input, output)
      @input  = input
      @output = output
      @board  = nil
    end

    attr_reader :input, :output, :board
    private     :input, :output, :board

    def solve
      parse_board
      solve_clues
      write_board
    end

    private

    def parse_board
      rows, columns = input.gets.scan(/\d+/).map(&:to_i)
      @board        = Board.new(
        Array.new(rows) { input.gets.chars.first(columns) }
      )
    end

    def solve_clues
      Strategy.load
      %i[across down].each do |direction|
        count = gets.to_i
        count.times do
          row, column, clue = gets.split(" ", 3).map.with_index { |str, i|
            i < 2 ? str.to_i : str.strip
          }
          if (strategy = Strategy.match(clue))
            board.send("record_#{direction}", row, column, strategy.answer)
          else
            warn "No match:  #{clue}"
          end
        end
      end
    end

    def write_board
      output.puts board
    end
  end
end
