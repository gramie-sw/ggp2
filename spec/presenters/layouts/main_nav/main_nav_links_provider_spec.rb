describe MainNavLinksProvider do

  subject { MainNavLinksProvider.create(:active_marker) }

  describe '#links' do

    let(:current_user) { User.new(id: 5, admin: false) }

    it 'should return links' do
      subject.links current_user
    end
  end
end