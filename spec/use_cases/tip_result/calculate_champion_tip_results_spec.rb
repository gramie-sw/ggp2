describe CalculateChampionTipResults do

  let(:teams) do
    [create(:team),
     create(:team)]
  end

  let(:champion_team) { teams.second }

  let!(:champion_tips) do
    [create(:champion_tip, team: teams.second),
     create(:champion_tip, team: teams.first),
     # we check that also ChampionTips with no Team will get an result
     create(:champion_tip, team: nil)]
  end

  subject { CalculateChampionTipResults.new champion_team }

  describe '#run' do

    it 'should calculate result on all ChampionTips and save them' do

      subject.run

      actual_champion_tips = ChampionTip.all
      expect(actual_champion_tips.first.result).to eq ChampionTip::RESULTS[:correct]
      expect(actual_champion_tips.second.result).to eq ChampionTip::RESULTS[:incorrect]
      expect(actual_champion_tips.third.result).to eq ChampionTip::RESULTS[:incorrect]
    end
  end
end