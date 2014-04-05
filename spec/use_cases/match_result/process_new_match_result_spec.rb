describe ProcessNewMatchResult do

  describe '#run' do

    let(:match_id) { 5 }

    context 'when tournament has no champion_team' do

      it 'should calculate results of tips and update ranking for match of given match_id' do
        Tournament.any_instance.should_receive(:champion_team).and_return(nil)

        tip_result_service = TipResultService.new(match_id: nil)
        TipResultService.should_receive(:new).with(match_id: match_id).and_return(tip_result_service)
        tip_result_service.should_receive(:update_tips_with_result).ordered

        CalculateChampionTipResults.any_instance.should_receive(:run).never

        update_ranking = UpdateRanking.new
        UpdateRanking.should_receive(:new).and_return(update_ranking)
        update_ranking.should_receive(:run).with(match_id).ordered

        subject.run(match_id)
      end
    end

    context 'when tournament has champion_team' do

      it 'should calculate results of tips, champion_tips and update ranking for match of given match_id' do
        tournament = Tournament.new
        Tournament.should_receive(:new).and_return(tournament)
        tournament.should_receive(:champion_team).and_return(ChampionTip.new)

        tip_result_service = TipResultService.new(match_id: nil)
        TipResultService.should_receive(:new).with(match_id: match_id).and_return(tip_result_service)
        tip_result_service.should_receive(:update_tips_with_result).ordered

        calculate_champion_tip_results = CalculateChampionTipResults.new
        CalculateChampionTipResults.should_receive(:new).and_return(calculate_champion_tip_results)
        calculate_champion_tip_results.should_receive(:run).with(tournament)

        update_ranking = UpdateRanking.new
        UpdateRanking.should_receive(:new).and_return(update_ranking)
        update_ranking.should_receive(:run).with(match_id).ordered

        subject.run(match_id)
      end
    end


  end
end