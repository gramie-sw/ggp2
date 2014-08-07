describe CalculateChampionTipResults do

  subject { CalculateChampionTipResults.new }

  describe '#run' do

    it 'should set result on all ChampionTips and save them' do
      champion_team = Team.new(id: 5)
      tournament = Tournament.new
      champion_tip_result_setter = ChampionTipResultSetter.new nil

      champion_tips = [ChampionTip.new, ChampionTip.new]

      expect(tournament).to receive(:champion_team).and_return(champion_team)
      expect(ChampionTipResultSetter).to receive(:new).with(champion_team).and_return(champion_tip_result_setter)
      expect(ChampionTip).to receive(:all).and_return(champion_tips)

      expect(champion_tip_result_setter).to receive(:set_result).ordered.with(champion_tips.first)
      expect(champion_tips.first).to receive(:save).ordered

      expect(champion_tip_result_setter).to receive(:set_result).ordered.with(champion_tips.second)
      expect(champion_tips.second).to receive(:save).ordered

      subject.run(tournament)
    end
  end

end