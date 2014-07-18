require_relative "../president_list"
require_relative "../name"

module Crossword
  class PresidentAfter < Strategy
    CLUE_REGEX = /
      \A (?<name>First|Last) \s+ name \s+ of \s+ the \s+
      next \s+ President \s+ of \s+ the \s+ United \s+ States \s+ after \s+
      (?<before>.+) \z
    /x

    def answer
      id  = PresidentList.find_by_name(
        Name.new(match_data[:before])
      )[:presidency].to_i + 1
      PresidentList
        .find_by_number(id.to_s)[:president]
        .send("#{match_data[:name].downcase}_name")
    end
  end
end
