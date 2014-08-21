describe AwardCeremoniesShowPresenter do

  let(:tournament) { Tournament.new }
  subject { AwardCeremoniesShowPresenter.new tournament }

  it 'should provide places accessors' do
    expect(subject).to respond_to(:places)
    expect(subject).to respond_to(:places=)
  end

  describe '#description_one' do

    context 'when champion_team present' do

      it 'should return description text on with champion_team' do
        champion_team = Team.new
        allow(champion_team).to receive(:name).and_return('Germany')
        expect(tournament).to receive(:champion_team).and_return(champion_team)
        expect(subject.description_one).to eq t('award_ceremony.description_one', champion_team: champion_team.name)
      end
    end

    context 'when champion_team is not present' do

      it 'should return description text on without champion_team' do
        expect(tournament).to receive(:champion_team).and_return(nil)
        expect(subject.description_one).to eq t('award_ceremony.description_one', champion_team: nil)
      end
    end
  end
end