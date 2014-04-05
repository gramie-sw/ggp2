describe ProcessNewMatchResult do

  it 'should calculate results of tips, champion_tips and update ranking' do
    user_1 = create(:player)
    user_2 = create(:player)

    team_1 = create(:team)
    team_2 = create(:team)

    champion_tip_1 = create(:champion_tip, user: user_1, team: team_1)
    champion_tip_2 = create(:champion_tip, user: user_2, team: team_2)

    match = create(:match, team_1: team_1, team_2: team_2, score_team_1: 1, score_team_2: 4)

    tip_1 = create(:tip, user: user_1, match: match, score_team_1: 1, score_team_2: 2)
    tip_2 = create(:tip, user: user_2, match: match, score_team_1: 1, score_team_2: 4)

    subject.run(match.id)

    RankingItem.count.should eq 4

    champion_tip_1.reload
    champion_tip_1.should_not be_correct
    champion_tip_2.reload
    champion_tip_2.should be_correct

    tip_1.reload
    tip_1.should be_correct_tendency_only
    tip_2.reload
    tip_2.should be_correct

    RankingItem.where(match_id: nil, position: 1).first.user_id.should eq user_2.id

    Property.last_tip_ranking_set_match_id.should eq match.id
    Property.champion_tip_ranking_set_exists?.should be_true
  end
end