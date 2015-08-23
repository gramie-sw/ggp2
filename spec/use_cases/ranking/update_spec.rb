describe Ranking::Update do

  subject { Ranking::Update }

  let(:user_1) { create(:player) }
  let(:user_2) { create(:player) }
  let(:user_3) { create(:player) }
  let(:match_1) { create(:match) }
  let(:match_2) { create(:match) }

  before :each do
    create(:tip, user: user_1, match: match_1, result: Tip::RESULTS[:correct_tendency_only])
    create(:tip, user: user_1, match: match_2, result: Tip::RESULTS[:incorrect])
    create(:tip, user: user_2, match: match_1, result: Tip::RESULTS[:incorrect])
    create(:tip, user: user_2, match: match_2, result: Tip::RESULTS[:correct])
    create(:tip, user: user_3, match: match_1, result: Tip::RESULTS[:correct])
    create(:tip, user: user_3, match: match_2, result: Tip::RESULTS[:correct_tendency_only])
    create(:champion_tip, user: user_1, result: ChampionTip::RESULTS[:correct])
    create(:champion_tip, user: user_2, result: ChampionTip::RESULTS[:incorrect])
    create(:champion_tip, user: user_3, result: ChampionTip::RESULTS[:incorrect])
  end

  it 'should create RankingItems for given match_id and ChampionTips' do

    subject.run(match_id: match_1.id)

    # match 1 ranking
    actual_ranking_items = RankingItem.all
    expect(actual_ranking_items.count).to eq 3

    ranking_1_first_ranking_item = RankingItem.where(match_id: match_1.id, position: 1).first
    expect(ranking_1_first_ranking_item.user_id).to eq user_3.id
    expect(ranking_1_first_ranking_item.points).to eq Ggp2.config.correct_tip_points

    ranking_1_second_ranking_item = RankingItem.where(match_id: match_1.id, position: 2).first
    expect(ranking_1_second_ranking_item.user_id).to eq user_1.id
    expect(ranking_1_second_ranking_item.points).to eq Ggp2.config.correct_tendency_tip_only_points

    ranking_1_third_ranking_item = RankingItem.where(match_id: match_1.id, position: 3).first
    expect(ranking_1_third_ranking_item.user_id).to eq user_2.id
    expect(ranking_1_third_ranking_item.points).to eq 0

    subject.run(match_id: match_2.id)

    # match 2 ranking
    actual_ranking_items = RankingItem.all
    expect(actual_ranking_items.count).to eq 9

    ranking_2_first_ranking_item = RankingItem.where(match_id: match_2.id, position: 1).first
    expect(ranking_2_first_ranking_item.user_id).to eq user_3.id
    expect(ranking_2_first_ranking_item.points).
        to eq (Ggp2.config.correct_tendency_tip_only_points + Ggp2.config.correct_tip_points)

    ranking_2_second_ranking_item = RankingItem.where(match_id: match_2.id, position: 2).first
    expect(ranking_2_second_ranking_item.user_id).to eq user_2.id
    expect(ranking_2_second_ranking_item.points).to eq Ggp2.config.correct_tip_points

    ranking_2_third_ranking_item = RankingItem.where(match_id: match_2.id, position: 3).first
    expect(ranking_2_third_ranking_item.user_id).to eq user_1.id
    expect(ranking_2_third_ranking_item.points).to eq Ggp2.config.correct_tendency_tip_only_points

    # champion tip ranking
    ranking_3_first_ranking_item = RankingItem.where(match_id: nil, position: 1).first
    expect(ranking_3_first_ranking_item.user_id).to eq user_1.id
    expect(ranking_3_first_ranking_item.points).
        to eq (Ggp2.config.correct_tendency_tip_only_points + Ggp2.config.correct_champion_tip_points)

    ranking_3_second_ranking_item = RankingItem.where(match_id: nil, position: 2).first
    expect(ranking_3_second_ranking_item.user_id).to eq user_3.id
    expect(ranking_3_second_ranking_item.points).
        to eq (Ggp2.config.correct_tendency_tip_only_points + Ggp2.config.correct_tip_points)

    ranking_3_second_ranking_item = RankingItem.where(match_id: nil, position: 3).first
    expect(ranking_3_second_ranking_item.user_id).to eq user_2.id
    expect(ranking_3_second_ranking_item.points).to eq Ggp2.config.correct_tip_points

    expect(Property.last_tip_ranking_set_match_id).to eq match_2.id
    expect(Property.champion_tip_ranking_set_exists?).to be_truthy
  end

  it 'should override existing RakingItems for given and subsequent matches' do

    subject.run(match_id: match_2.id)

    # match 2 ranking
    actual_ranking_items = RankingItem.all
    expect(actual_ranking_items.count).to eq 6

    ranking_1_first_ranking_item = RankingItem.where(match_id: match_2.id, position: 1).first
    expect(ranking_1_first_ranking_item.user_id).to eq user_2.id
    expect(ranking_1_first_ranking_item.points).to eq Ggp2.config.correct_tip_points

    ranking_1_second_ranking_item = RankingItem.where(match_id: match_2.id, position: 2).first
    expect(ranking_1_second_ranking_item.user_id).to eq user_3.id
    expect(ranking_1_second_ranking_item.points).to eq Ggp2.config.correct_tendency_tip_only_points

    ranking_1_third_ranking_item = RankingItem.where(match_id: match_2.id, position: 3).first
    expect(ranking_1_third_ranking_item.user_id).to eq user_1.id
    expect(ranking_1_third_ranking_item.points).to eq 0

    subject.run(match_id: match_1.id)

    # match 2 ranking again
    actual_ranking_items = RankingItem.all
    expect(actual_ranking_items.count).to eq 9

    actual_ranking_items = RankingItem.all
    expect(actual_ranking_items.count).to eq 9

    ranking_2_first_ranking_item = RankingItem.where(match_id: match_2.id, position: 1).first
    expect(ranking_2_first_ranking_item.user_id).to eq user_3.id
    expect(ranking_2_first_ranking_item.points).
        to eq (Ggp2.config.correct_tendency_tip_only_points + Ggp2.config.correct_tip_points)

    ranking_2_second_ranking_item = RankingItem.where(match_id: match_2.id, position: 2).first
    expect(ranking_2_second_ranking_item.user_id).to eq user_2.id
    expect(ranking_2_second_ranking_item.points).to eq Ggp2.config.correct_tip_points

    ranking_2_third_ranking_item = RankingItem.where(match_id: match_2.id, position: 3).first
    expect(ranking_2_third_ranking_item.user_id).to eq user_1.id
    expect(ranking_2_third_ranking_item.points).to eq Ggp2.config.correct_tendency_tip_only_points
  end
end