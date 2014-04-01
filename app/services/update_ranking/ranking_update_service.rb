class RankingUpdateService

  def initialize(ranking_item_set_service:, ranking_item_set_updater:)
    @ranking_item_set_service = ranking_item_set_service
    @ranking_item_set_updater = ranking_item_set_updater
  end

  def update_ranking_progressive(match_id, ordered_match_ids)
    #Todo implement
    #should use update_ranking_for_match several times which completely tested
  end

  private

  attr_reader :ranking_item_set_service, :ranking_item_set_factory, :tip_repository
end