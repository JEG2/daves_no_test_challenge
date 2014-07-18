require_relative "../element_list"

module Crossword
  class ElementBySymbol < Strategy
    CLUE_REGEX = /\AChemical element with the symbol (?<symbol>\S+)\z/

    def answer
      ElementList.find_by_symbol(match_data[:symbol]).first
    end
  end
end
