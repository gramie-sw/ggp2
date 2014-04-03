describe RankingSetFactory do

  subject { RankingSetFactory }

  describe '::create_for_tip_ranking_set' do

    it 'should return properly instantiated RankingSetFactory' do
      expected_ranking_set_factory = double('RankingSetFactory')
      RankingSetFactory.should_receive(:new).
          with(ranking_item_factory: TipRankingItemFactory, ranking_items_position_setter: RankingItemsPositionSetter).
          and_return(expected_ranking_set_factory)

      subject.create_for_tip_ranking_set.should be expected_ranking_set_factory
    end
  end

  describe '::create_for_champion_tip_ranking_set' do

    it 'should return properly instantiated RankingSetFactory' do
      expected_ranking_set_factory = double('RankingSetFactory')
      RankingSetFactory.should_receive(:new).
          with(ranking_item_factory: ChampionTipRankingItemFactory, ranking_items_position_setter: RankingItemsPositionSetter).
          and_return(expected_ranking_set_factory)

      subject.create_for_champion_tip_ranking_set.should be expected_ranking_set_factory
    end
  end


  describe '#build' do

    let(:ranking_item_factory) { TipRankingItemFactory }
    let(:ranking_items_position_setter) { RankingItemPositionSetter }
    subject do
      RankingSetFactory.new(
          ranking_item_factory: ranking_item_factory,
          ranking_items_position_setter: ranking_items_position_setter
      )
    end

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

      previous_ranking_item_set = RankingSet.new(match_id: 5, ranking_items: previous_ranking_items)

      ranking_item_factory.
          should_receive(:build).with(tips.first, previous_ranking_items.first).and_return(new_ranking_items.first)
      ranking_item_factory.
          should_receive(:build).with(tips.second, previous_ranking_items.second).and_return(new_ranking_items.second)

      ranking_items_position_setter.should_receive(:set_positions).with(new_ranking_items).ordered

      RankingSet.should_receive(:new).with(match_id: 6, ranking_items: new_ranking_items).ordered.and_call_original

      actual_ranking_item_set = subject.build(6, tips, previous_ranking_item_set)
      actual_ranking_item_set.should be_kind_of(RankingSet)
    end
  end
end