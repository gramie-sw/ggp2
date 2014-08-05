describe ChampionTipResultSetter do

  let(:champion_team) { Team.new(id: 5) }
  subject { ChampionTipResultSetter.new(champion_team) }

  describe '#set_result' do

    context 'when team_id of given ChampionTip equals team_id of champion_team' do

      let(:champion_tip) { ChampionTip.new(team_id: 5) }

      it 'should set result to correct' do
        subject.set_result(champion_tip)
        champion_tip.result.should eq ChampionTip::RESULTS[:correct]
      end
    end

    context 'when team_id of given ChampionTip  does not equal team_id of champion_team' do

      let(:champion_tip) { ChampionTip.new(team_id: 6) }

      it 'should set result to incorrect' do
        subject.set_result(champion_tip)
        champion_tip.result.should eq ChampionTip::RESULTS[:incorrect]
      end
    end

  end

end