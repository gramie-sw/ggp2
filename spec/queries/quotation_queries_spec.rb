describe QuotationQueries do

  describe '#find_sample' do

    it 'returns random Quotation' do
      actual_quotation = subject.find_sample
      expect(actual_quotation).to be_instance_of Quotation
      expect(actual_quotation.author).not_to be_nil
      expect(actual_quotation.content).not_to be_nil
    end
  end
end