describe MatchResults::Delete do

  subject { MatchResults::Delete }

  let(:match) { create(:match, score_team_1: 1, score_team_2: 2) }

  let!(:tips) do
    [create(:tip, match: match, result: 1),
     create(:tip, match: match, result: 0)]
  end

  let!(:champion_tips) do
    [create(:champion_tip, result: 1),
     create(:champion_tip, result: 0)]
  end

  it 'clears result on Match and Tips for given match_id and ChampionTips' do
    subject.run(match_id: match.id)

    ensure_result_is_cleared
  end

  it 'calls RankingSets::Delete with given match_id and UpdateUserBadges after clearing results' do
    expect(RankingSets::Delete).to receive(:run).with(match_id: match.id).ordered do
      ensure_result_is_cleared
    end

    expect(UpdateUserBadges).to receive(:run).with(group: :tip)

    subject.run(match_id: match.id)
  end

  def ensure_result_is_cleared
    match.reload
    expect(match.score_team_1).to be_nil
    expect(match.score_team_2).to be_nil

    tips.each(&:reload)
    expect(tips.first.result).to be_nil
    expect(tips.second.result).to be_nil

    champion_tips.each(&:reload)
    expect(champion_tips.first.result).to be_nil
    expect(champion_tips.second.result).to be_nil
  end
end