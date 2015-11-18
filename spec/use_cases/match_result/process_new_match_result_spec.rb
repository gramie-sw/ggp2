describe ProcessNewMatchResult do

  describe '#run' do

    let(:match_id) { 5 }

    context 'when tournament has no champion_team' do

      it 'calculates results of tips and update ranking for match of given match_id' do
        expect_any_instance_of(Tournament).to receive(:champion_team).and_return(nil)

        expect(Tips::SetResults).to receive(:run).with(match_id: match_id).ordered
        expect(RankingSets::Update).to receive(:run).with(match_id: match_id).ordered

        expect(ChampionTips::SetResults).not_to receive(:run)

        subject.run(match_id)
      end
    end

    context 'when tournament has champion_team' do

      it 'calculates results of tips, champion_tips and update ranking for match of given match_id' do
        champion_team = Team.new(id: 98)

        tournament = Tournament.new
        expect(Tournament).to receive(:new).and_return(tournament)
        expect(tournament).to receive(:champion_team).twice.and_return(champion_team)

        expect(Tips::SetResults).to receive(:run).with(match_id: match_id).ordered
        expect(ChampionTips::SetResults).to receive(:run).with(champion_team_id: champion_team.id).ordered
        expect(RankingSets::Update).to receive(:run).with(match_id: match_id).ordered

        subject.run(match_id)
      end
    end
  end
end