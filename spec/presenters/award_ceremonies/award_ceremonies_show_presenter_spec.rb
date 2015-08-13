describe AwardCeremoniesShowPresenter do

  let(:tournament) { Tournament.new }
  let(:champion_title) { 'World Champion' }
  subject { AwardCeremoniesShowPresenter.new tournament }

  it 'should provide places accessors' do
    expect(subject).to respond_to(:places)
    expect(subject).to respond_to(:places=)
  end

  describe '#description_one' do

    before :each do
      expect(tournament).to respond_to(:champion_title)
      expect(tournament).to respond_to(:champion_team)
      allow(tournament).to receive(:champion_title).and_return(champion_title)
    end


    context 'when champion_team present' do

      it 'should return description text on with champion_team' do
        champion_team = Team.new
        allow(champion_team).to receive(:name).and_return('Germany')
        expect(tournament).to receive(:champion_team).and_return(champion_team)
        expect(subject.description_one).to eq t('award_ceremony.description_one',
                                                champion_team: champion_team.name,
                                                champion_title: champion_title)
      end
    end

    context 'when champion_team is not present' do

      it 'should return description text on without champion_team' do
        expect(tournament).to receive(:champion_team).and_return(nil)
        expect(subject.description_one).to eq t('award_ceremony.description_one',
                                                champion_team: nil,
                                                champion_title: champion_title)
      end
    end
  end
end