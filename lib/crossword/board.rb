module Crossword
  class Board
    def initialize(squares)
      @squares = squares
    end

    attr_reader :squares
    private     :squares

    def record_across(row, column, answer)
      answer.downcase.chars.each_with_index do |char, i|
        record(row, column + i, char)
      end
    end

    def record_down(row, column, answer)
      answer.downcase.chars.each_with_index do |char, i|
        record(row + i, column, char)
      end
    end

    def to_s
      squares.map { |row| row.join }.join("\n")
    end

    private

    def record(row, column, char)
      square = squares[row][column]

      fail "Outside of board"  if square.nil?
      fail "Outside of answer" if square == "."
      fail "Answer mismatch"   if !["#", char].include?(char)

      square.replace(char)
    end
  end
end
