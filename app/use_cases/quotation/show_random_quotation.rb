class ShowRandomQuotation

  def run
    QuotationRepository.sample
  end

end