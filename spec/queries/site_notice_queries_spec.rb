describe SiteNoticeQueries do

  describe '::contact' do

    it 'returns contact' do
      contact = SiteNoticeQueries.contact

      expect(contact['person']).to eq 'Max Mustermann'
      expect(contact['address']['street']).to eq 'Example Street 42'
      expect(contact['address']['postal']).to eq '01099'
      expect(contact['address']['city']).to eq 'Dresden'
      expect(contact['email']).to eq 'test@test.com'
    end
  end
end