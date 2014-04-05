describe UpdateRanking do

  it 'should create RankingItems for given match_id and ChampionTips' do
    user_1 = create(:player)
    user_2 = create(:player)
    match_1 = create(:match)
    match_2 = create(:match)

    create(:tip, user: user_1, match: match_1, result: Tip::RESULTS[:correct_tendency_only])
    create(:tip, user: user_1, match: match_2, result: Tip::RESULTS[:incorrect])
    create(:tip, user: user_2, match: match_1, result: Tip::RESULTS[:incorrect])
    create(:tip, user: user_2, match: match_2, result: Tip::RESULTS[:correct])
    create(:champion_tip, user: user_1, result: ChampionTip::RESULTS[:correct])
    create(:champion_tip, user: user_2, result: ChampionTip::RESULTS[:incorrect])

    subject.run(match_1.id)
    subject.run(match_2.id)

    actual_ranking_items = RankingItem.all
    actual_ranking_items.count.should eq 6

    ranking_1_first_ranking_item = RankingItem.where(match_id: match_1.id, position: 1).first
    ranking_1_first_ranking_item.user_id.should eq user_1.id
    ranking_1_first_ranking_item.points.should eq Ggp2.config.correct_tendency_tip_only_points

    ranking_2_first_ranking_item = RankingItem.where(match_id: match_2.id, position: 1).first
    ranking_2_first_ranking_item.user_id.should eq user_2.id
    ranking_2_first_ranking_item.points = Ggp2.config.correct_tip_points

    ranking_3_first_ranking_item = RankingItem.where(match_id: nil, position: 1).first
    ranking_3_first_ranking_item.user_id.should eq user_1.id
    ranking_3_first_ranking_item.points.should eq Ggp2.config.correct_tendency_tip_only_points + Ggp2.config.correct_champion_tip_points

    Property.last_tip_ranking_set_match_id.should eq match_2.id
    Property.champion_tip_ranking_set_exists?.should be_true
  end
end