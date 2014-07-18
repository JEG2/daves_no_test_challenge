require_relative "../pokemon_list"

module Crossword
  class PokemonNumber < Strategy
    CLUE_REGEX = /\APokemon with number #(?<number>\d+)\z/

    def answer
      PokemonList.find_by_number(match_data[:number])[:identifier]
    end
  end
end
