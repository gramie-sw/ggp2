describe CalculateChampionTipResults do

  let(:teams) {
    [
      create(:team),
      create(:team)
    ]
  }

  let(:champion_team) { teams.second }

  let(:champion_tips) {
    [
      create(:champion_tip, team: teams.second),
      create(:champion_tip, team: teams.first)
    ]
  }

  subject { CalculateChampionTipResults.new champion_team }

  before :each do
    champion_tips
  end

  describe '#run' do

    it 'should calculate result on all ChampionTips and save them' do

      subject.run

      actual_champion_tips = ChampionTip.all
      expect(actual_champion_tips.first.result).to eq ChampionTip::RESULTS[:correct]
      expect(actual_champion_tips.second.result).to eq ChampionTip::RESULTS[:incorrect]
    end
  end
end