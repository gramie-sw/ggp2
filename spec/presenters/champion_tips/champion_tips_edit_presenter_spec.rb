describe ChampionTipsEditPresenter do

  let(:champion_tip) { create(:champion_tip) }
  subject { ChampionTipsEditPresenter.new champion_tip }


  it 'should respond to champion_tip' do
    should respond_to :champion_tip
  end

  describe '#teams' do

    it 'should return Teams ordered by country name' do
      Team.should_receive(:order_by_country_name).and_return(:teams)
      subject.teams.should be :teams
    end
  end

end