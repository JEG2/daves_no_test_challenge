require_relative "crossword/solver"

module Crossword
  module_function

  def solve(*args)
    Solver.new(*args).solve
  end
end
