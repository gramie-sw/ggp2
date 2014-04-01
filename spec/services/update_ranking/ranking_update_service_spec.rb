describe RankingUpdateService do

  let(:ranking_item_set_service) { RankingItemSetService.new(ranking_item_repository: RankingItem) }
  let(:ranking_item_set_updater) do
    RankingItemSetUpdater.new(
        ranking_item_set_service: ranking_item_set_service,
        ranking_item_set_factory: double('RankingItemSetFactory'),
        tip_repository: Tip
    )
  end
  subject do
    RankingUpdateService.new(
        ranking_item_set_service: ranking_item_set_service,
        ranking_item_set_updater: ranking_item_set_updater,
    )
  end

  describe '#update_ranking_progressive_for_match' do

    context 'when there are no next RankingItemSet' do

      it 'should update only ranking of given match_id' do
      end
    end
  end
end