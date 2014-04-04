describe UpdateRanking do

  it 'should create RankingItems for given match_id and ChampionTips' do
    player_1 = create(:player)
    player_2 = create(:player)
    match_1 = create(:match)
    match_2 = create(:match)

    create(:tip, user: player_1, match: match_1, result: Tip::RESULTS[:correct_tendency])
    create(:tip, user: player_1, match: match_2, result: Tip::RESULTS[:incorrect])
    create(:tip, user: player_2, match: match_1, result: Tip::RESULTS[:incorrect])
    create(:tip, user: player_2, match: match_2, result: Tip::RESULTS[:correct])
    create(:champion_tip, user: player_1, result: ChampionTip::RESULTS[:correct])
    create(:champion_tip, user: player_2, result: ChampionTip::RESULTS[:incorrect])

    subject.run(match_1.id)
    subject.run(match_2.id)

    actual_ranking_items = RankingItem.all
    actual_ranking_items.count.should eq 6

    RankingItem.where(match_id: match_1.id, position: 1).first.user_id.should eq player_1.id
    RankingItem.where(match_id: match_2.id, position: 1).first.user_id.should eq player_2.id
    RankingItem.where(match_id: nil, position: 1).first.user_id.should eq player_1.id

    Property.last_tip_ranking_set_match_id.should eq match_2.id
    Property.champion_tip_ranking_set_exists?.should be_true
  end
end