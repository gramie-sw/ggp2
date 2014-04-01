describe RankingItemSetUpdater do

  let(:tip_repository) { Tip }
  let(:ranking_item_set_service) { RankingItemSetService.new(ranking_item_repository: RankingItem) }
  let(:ranking_item_set_factory) do
    RankingItemSetFactory.new(
        ranking_item_position_service: RankingItemPositionService,
        ranking_item_factory: RankingItemFactory
    )
  end
  subject do
    RankingItemSetUpdater.new(
        ranking_item_set_service: ranking_item_set_service,
        ranking_item_set_factory: ranking_item_set_factory,
        tip_repository: tip_repository
    )
  end

  describe '#update_ranking_for_match' do

    let(:match_id) { 5 }
    let(:tips) { double('TipCollection') }
    let(:previous_ranking_item_set) { double('RankingItemSet') }
    let(:new_ranking_item_set) { double('RankingItemSet') }
    it 'should create and save new RankingItemSet for given match_id' do
      tip_repository.should_receive(:tips_by_match_id).with(match_id).and_return(tips)
      ranking_item_set_factory.should_receive(:build).with(match_id, tips, previous_ranking_item_set).and_return(new_ranking_item_set)
      ranking_item_set_service.should_receive(:save).with(new_ranking_item_set)

      subject.update_ranking_item_set(match_id, previous_ranking_item_set)
    end
  end
end