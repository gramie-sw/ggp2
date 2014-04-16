describe AwardCeremoniesShowPresenter do

  let(:tournament) { Tournament.new }
  subject { AwardCeremoniesShowPresenter.new tournament }

  it 'should provide first_places accessors' do
    subject.should respond_to(:first_places)
    subject.should respond_to(:first_places=)
  end

  it 'should provide second_places accessors' do
    subject.should respond_to(:second_places)
    subject.should respond_to(:second_places=)
  end

  it 'should provide third_places accessors' do
    subject.should respond_to(:third_places)
    subject.should respond_to(:third_places=)
  end

  describe '#description_one' do

    context 'when champion_team present' do

      it 'should return description text on with champion_team' do
        champion_team = Team.new
        champion_team.stub(:name).and_return('Germany')
        tournament.should_receive(:champion_team).and_return(champion_team)
        subject.description_one.should eq t('award_ceremony.description_one', champion_team: champion_team.name)
      end
    end

    context 'when champion_team is not present' do

      it 'should return description text on without champion_team' do
        tournament.should_receive(:champion_team).and_return(nil)
        subject.description_one.should eq t('award_ceremony.description_one', champion_team: nil)
      end
    end
  end
end