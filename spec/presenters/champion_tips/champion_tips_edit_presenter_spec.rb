describe ChampionTipsEditPresenter do

  let(:champion_tip) { create(:champion_tip) }
  subject { ChampionTipsEditPresenter.new champion_tip }


  it 'should respond to champion_tip' do
    is_expected.to respond_to :champion_tip
  end

  describe '#teams' do

    it 'should return Teams ordered by country name' do
      expect(Team).to receive(:order_by_country_name_asc).and_return(:teams)
      expect(subject.teams).to be :teams
    end
  end

end