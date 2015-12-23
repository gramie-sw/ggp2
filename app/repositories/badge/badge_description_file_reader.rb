module BadgeDescriptionFileReader

  class << self

    def read
      @loaded_badges ||= recursive_symbolize_keys(YAML.load_file(Ggp2.config.badges_file))
    end

    private

    def recursive_symbolize_keys(h)
      case h
        when Hash
          Hash[
              h.map do |k, v|
                [k.respond_to?(:to_sym) ? k.to_sym : k, recursive_symbolize_keys(v)]
              end
          ]
        when Enumerable
          h.map { |v| recursive_symbolize_keys(v) }
        else
          h
      end
    end
  end
end