class RankingItemSetUpdater

  def initialize(ranking_item_set_service:, ranking_item_set_factory:, tip_repository:)
    @ranking_item_set_service = ranking_item_set_service
    @ranking_item_set_factory = ranking_item_set_factory
    @tip_repository = tip_repository
  end

  def update_ranking_item_set match_id, previous_ranking_item_set
    tips = tip_repository.tips_by_match_id(match_id)
    ranking_item_set = ranking_item_set_factory.build(match_id, tips, previous_ranking_item_set)
    ranking_item_set_service.save(ranking_item_set)
  end

  private

  attr_reader :ranking_item_set_service, :ranking_item_set_factory, :tip_repository
end