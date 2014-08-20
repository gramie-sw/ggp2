class FindRandomQuotation

  def run
    QuotationRepository.sample
  end

end