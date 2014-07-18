require_relative "board"

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
      write_board
    end

    private

    def parse_board
      rows, columns = input.gets.scan(/\d+/).map(&:to_i)
      @board        = Board.new(
        Array.new(rows) { input.gets.chars.first(columns) }
      )
    end

    def write_board
      output.puts board
    end
  end
end
