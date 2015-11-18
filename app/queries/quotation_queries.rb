module QuotationQueries

  class << self

    def find_sample
      entry = collection.sample
      Quotation.new(entry)

    end

    private

    def collection
      @collection ||= YAML.load_file(Ggp2.config.quotations_file)
    end
  end
end