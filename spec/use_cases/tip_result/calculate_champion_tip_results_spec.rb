describe CalculateChampionTipResults do

  subject { CalculateChampionTipResults.new }

  describe '#run' do

    it 'should set result on all ChampionTips and save them' do
      champion_team = Team.new(id: 5)
      tournament = Tournament.new
      champion_tip_result_setter = ChampionTipResultSetter.new nil

      champion_tips = [ChampionTip.new, ChampionTip.new]

      tournament.should_receive(:champion_team).and_return(champion_team)
      ChampionTipResultSetter.should_receive(:new).with(champion_team).and_return(champion_tip_result_setter)
      ChampionTip.should_receive(:all).and_return(champion_tips)

      champion_tip_result_setter.should_receive(:set_result).ordered.with(champion_tips.first)
      champion_tips.first.should_receive(:save).ordered

      champion_tip_result_setter.should_receive(:set_result).ordered.with(champion_tips.second)
      champion_tips.second.should_receive(:save).ordered

      subject.run(tournament)
    end
  end

end