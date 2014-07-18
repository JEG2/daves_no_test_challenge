require_relative "../pokemon_list"

module Crossword
  class EvoledPokemon < Strategy
    CLUE_REGEX = /\APokemon which evolves (?<direction>from|into) (?<name>\S+)\z/

    def answer
      id  = PokemonList.find_by_name(match_data[:name].downcase)[:id].to_i
      id += match_data[:direction] == "from" ? 1 : -1
      PokemonList.find_by_number(id.to_s)[:identifier]
    end
  end
end
