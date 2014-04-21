describe MainNavLinksProvider do

  subject { MainNavLinksProvider.create(:active_marker) }

  describe '#links' do

    let(:current_user) { User.new(id: 5, admin: false) }
    let(:tournament) { instance_double('Tournament') }

    before :each do
      allow(tournament).to receive(:finished?)
    end


    it 'should return links' do
      subject.links current_user, tournament
    end
  end
end