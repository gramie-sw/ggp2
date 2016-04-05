describe MatchResults::Update do
  subject { MatchResults::Update }

  let(:match) { create(:match, score_team_1: nil, score_team_2: nil) }

  describe 'on success' do

    let(:attributes) { {score_team_1: 1, score_team_2: 2} }

    it 'updates result of match and return match_result' do
      match_result = subject.run(match_id: match.id, match_result_attributes: attributes)

      expect(match_result).to be_instance_of MatchResult
      expect(match_result.match_id).to be match.id
      expect(match_result.score_team_1).to be attributes[:score_team_1]
      expect(match_result.score_team_2).to be attributes[:score_team_2]

      ensure_result_of_match_has_been_updated
    end

    context 'when tournament has no champion_team' do

      it 'sets tip results and update ranking_set for given match_id' do
        expect_any_instance_of(Tournament).to receive(:champion_team).and_return(nil)
        expect(Tips::SetResults).to receive(:run).with(match_id: match.id) do
          ensure_result_of_match_has_been_updated
        end.ordered
        expect(RankingSets::Update).to receive(:run).with(match_id: match.id).ordered
        expect(UpdateUserBadges).to receive(:run).with(group: :tip).ordered
        expect(Users::UpdateMostValuableBadge).to receive(:run).ordered
        expect(ChampionTips::SetResults).not_to receive(:run)

        subject.run(match_id: match.id, match_result_attributes: attributes)
      end
    end

    context 'when tournament has champion_team' do

      it 'sets tip results, champion_tips results and update ranking_set for given match_id' do
        champion_team = Team.new(id: 98)

        expect_any_instance_of(Tournament).to receive(:champion_team).and_return(champion_team)
        expect(Tips::SetResults).to receive(:run).with(match_id: match.id) do
          ensure_result_of_match_has_been_updated
        end.ordered
        expect(ChampionTips::SetResults).to receive(:run).with(champion_team_id: champion_team.id).ordered
        expect(RankingSets::Update).to receive(:run).with(match_id: match.id).ordered
        expect(UpdateUserBadges).to receive(:run).with(group: :tip).ordered
        expect(Users::UpdateMostValuableBadge).to receive(:run).ordered

        subject.run(match_id: match.id, match_result_attributes: attributes)
      end
    end

    def ensure_result_of_match_has_been_updated
      match.reload
      expect(match.score_team_1).to be attributes[:score_team_1]
      expect(match.score_team_2).to be attributes[:score_team_2]
    end
  end

  describe 'on failure' do

    let(:attributes) { {score_team_1: 1, score_team_2: 'A'} }

    it 'updates result of match and return match_result' do
      match_result = subject.run(match_id: match.id, match_result_attributes: attributes)

      expect(match_result).to be_instance_of MatchResult
      expect(match_result.errors[:score_team_2]).to be_present

      match.reload
      expect(match.score_team_1).to be_nil
      expect(match.score_team_2).to be_nil
    end
  end
end