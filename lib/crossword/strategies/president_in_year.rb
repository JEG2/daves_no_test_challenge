require_relative "../president_list"

module Crossword
  class PresidentInYear < Strategy
    CLUE_REGEX = /
      \A (?<name>First|Last) \s+ name \s+ of \s+ the \s+
      President \s+ of \s+ the \s+ United \s+ States \s+ who \s+
      held \s+ the \s+ office \s+ in \s+ (?<year>\d+) \z
    /x

    def answer
      PresidentList
        .find_by_year(match_data[:year].to_i)[:president]
        .send("#{match_data[:name].downcase}_name")
    end
  end
end
