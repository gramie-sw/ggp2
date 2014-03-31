class RankingItemSetFactory

  def initialize(ranking_item_factory:, ranking_item_position_service:)
    @ranking_item_factory = ranking_item_factory
    @ranking_item_position_service = ranking_item_position_service
  end

  def build match_id, tips, previous_ranking_item_set
    ranking_items = create_ranking_items(tips, previous_ranking_item_set)
    ranking_item_position_service.set_positions(ranking_items)
    RankingItemSet.new(match_id: match_id, ranking_items: ranking_items)
  end

  private

  attr_reader :ranking_item_factory, :ranking_item_position_service

  def create_ranking_items tips, previous_ranking_item_set
    tips.map do |tip|
      ranking_item_factory.build(tip, previous_ranking_item_set.ranking_item_of_user(tip.user_id))
    end
  end
end