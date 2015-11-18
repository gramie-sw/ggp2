describe ChampionTips::SetResults do

  subject { ChampionTips::SetResults }

  let(:teams) do
    [create(:team),
     create(:team)]
  end

  let(:champion_team_id) { teams.second.id }

  let!(:champion_tips) do
    [create(:champion_tip, team: teams.second),
     create(:champion_tip, team: teams.first),
     # we check that also ChampionTips with no Team will get an result
     create(:champion_tip, team: nil)]
  end


  describe '#run' do

    it 'should calculate result on all ChampionTips and save them' do

      subject.run(champion_team_id: champion_team_id)

      actual_champion_tips = ChampionTip.all
      expect(actual_champion_tips.first.result).to eq ChampionTip::RESULTS[:correct]
      expect(actual_champion_tips.second.result).to eq ChampionTip::RESULTS[:incorrect]
      expect(actual_champion_tips.third.result).to eq ChampionTip::RESULTS[:incorrect]
    end
  end
end