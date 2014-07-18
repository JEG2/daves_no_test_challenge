module Crossword
  class Board
    def initialize(squares)
      @squares = squares
    end

    attr_reader :squares
    private     :squares

    def to_s
      squares.map { |row| row.join }.join("\n")
    end
  end
end
