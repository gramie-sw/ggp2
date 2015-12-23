module ColorCodeQueries

  class << self

    def all
      @color_codes ||= YAML.load_file(Ggp2.config.color_codes_file)
    end
  end
end