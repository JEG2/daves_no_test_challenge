require_relative "../element_list"

module Crossword
  class ElementByNumber < Strategy
    CLUE_REGEX = /\AChemical element with atomic number (?<number>\d+)\z/

    def answer
      ElementList.find_by_number(match_data[:number].to_i).first
    end
  end
end
