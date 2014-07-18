module Crossword
  class Name
    def initialize(full_name)
      @full_name = full_name
    end

    attr_reader :full_name
    private     :full_name

    def first_name
      full_name[/\A\w+/]
    end

    def last_name
      full_name[/\w+\z/]
    end

    def ==(other)
      first_name == other.first_name &&
      last_name  == other.last_name
    end
  end
end
