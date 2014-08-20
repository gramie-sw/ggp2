describe FindRandomQuotation do

  describe '#run' do

    it 'should return sample quotation' do
      actual_quotation = subject.run
      expect(actual_quotation).to be_instance_of Quotation
      expect(actual_quotation.author).not_to be_nil
      expect(actual_quotation.content).not_to be_nil
    end
  end
end