describe ProcessNewMatchResult do

  describe '#run' do

    let(:match_id) { 5 }

    context 'when tournament has no champion_team' do

      it 'should calculate results of tips and update ranking for match of given match_id' do

        expect_any_instance_of(Tournament).to receive(:champion_team).and_return(nil)

        calculate_tip_results = CalculateTipResults.new
        expect(CalculateTipResults).to receive(:new).and_return(calculate_tip_results)
        expect(calculate_tip_results).to receive(:run).with(match_id).ordered

        expect_any_instance_of(CalculateChampionTipResults).to receive(:run).never

        update_ranking = UpdateRanking.new
        expect(UpdateRanking).to receive(:new).and_return(update_ranking)
        expect(update_ranking).to receive(:run).with(match_id).ordered

        subject.run(match_id)
      end
    end

    context 'when tournament has champion_team' do

      it 'should calculate results of tips, champion_tips and update ranking for match of given match_id' do

        tournament = Tournament.new
        expect(Tournament).to receive(:new).and_return(tournament)
        expect(tournament).to receive(:champion_team).and_return(ChampionTip.new)

        calculate_tip_results = CalculateTipResults.new
        expect(CalculateTipResults).to receive(:new).and_return(calculate_tip_results)
        expect(calculate_tip_results).to receive(:run).with(match_id).ordered

        calculate_champion_tip_results = CalculateChampionTipResults.new
        expect(CalculateChampionTipResults).to receive(:new).and_return(calculate_champion_tip_results)
        expect(calculate_champion_tip_results).to receive(:run).with(tournament)

        update_ranking = UpdateRanking.new
        expect(UpdateRanking).to receive(:new).and_return(update_ranking)
        expect(update_ranking).to receive(:run).with(match_id).ordered

        subject.run(match_id)
      end
    end
  end
end