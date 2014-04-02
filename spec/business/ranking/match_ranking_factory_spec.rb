describe MatchRankingFactory do

  let(:ranking_item_factory) { RankingItemFactory }
  let(:ranking_item_position_service) { RankingItemPositionSetter }
  subject do
    MatchRankingFactory.new(
        ranking_item_factory: ranking_item_factory,
        ranking_item_position_service: ranking_item_position_service
    )
  end

  describe '#build' do

    it 'should return correct instantiated RankingItemSet' do
      previous_ranking_items = [
          RankingItem.new(id: 1, user_id: 3),
          RankingItem.new(id: 2, user_id: 4)
      ]

      tips = [
          Tip.new(id: 1, user_id: 3),
          Tip.new(id: 2, user_id: 4)
      ]

      new_ranking_items = [
          RankingItem.new(id: 3, user_id: 3),
          RankingItem.new(id: 4, user_id: 4)
      ]

      previous_ranking_item_set = MatchRanking.new(match_id: 5, ranking_items: previous_ranking_items)

      ranking_item_factory.
          should_receive(:build).with(tips.first, previous_ranking_items.first).and_return(new_ranking_items.first)
      ranking_item_factory.
          should_receive(:build).with(tips.second, previous_ranking_items.second).and_return(new_ranking_items.second)

      ranking_item_position_service.should_receive(:set_positions).with(new_ranking_items).ordered

      MatchRanking.should_receive(:new).with(match_id: 6, ranking_items: new_ranking_items).ordered.and_call_original

      actual_ranking_item_set = subject.build(6, tips, previous_ranking_item_set)
      actual_ranking_item_set.should be_kind_of(MatchRanking)
    end
  end
end