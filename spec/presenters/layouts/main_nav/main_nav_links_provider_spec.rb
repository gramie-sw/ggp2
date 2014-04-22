describe MainNavLinksProvider do

  include Rails.application.routes.url_helpers

  subject { MainNavLinksProvider.create(:active_marker) }

  describe '#links' do

    let(:current_user) { User.new(id: 5, admin: false) }
    let(:tournament) { instance_double('Tournament') }

    before :each do
      tournament.stub(:finished?)
    end

    context 'when current_user is player' do

      context 'when tournament is finished' do

        it 'should return award_ceremony as first link' do
          tournament.should_receive(:finished?).and_return(true)
          actual_links = subject.links current_user, tournament
          expect(actual_links.first.url).to eq award_ceremonies_path
        end
      end

      context 'when tournament is not finished' do

        it 'should return not award_ceremony as first link' do
          tournament.should_receive(:finished?).and_return(false)
          actual_links = subject.links current_user, tournament
          expect(actual_links.first.url).to_not eq award_ceremonies_path
        end
      end
    end
  end
end