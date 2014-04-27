describe QuotationRepository do

  describe '#sample' do

    it 'should return random Quotation' do
      actual_quotation = subject.sample
      expect(actual_quotation).to be_instance_of Quotation
      expect(actual_quotation.author).not_to be_nil
      expect(actual_quotation.content).not_to be_nil
    end
  end
end