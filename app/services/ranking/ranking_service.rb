class RankingService

  attr_reader :match

  def initialize(match: match)
    @match = match
  end

  def ranking_item_set
    @ranking_item_set ||= RankingItemSet.new match: match, match_ids: Match.match_ids
  end

  def update_all
    process_ranking_item_set = ranking_item_set
    loop do
      update process_ranking_item_set
      process_ranking_item_set = process_ranking_item_set.successor_ranking_item_set
      break unless process_ranking_item_set
    end
  end

  def update process_ranking_item_set
    process_ranking_item_set.destroy_existing_and_save_built_ranking_items build process_ranking_item_set
  end

  def build process_ranking_item_set
    RankingItemsPositionSetter.set_positions process_ranking_item_set.build_ranking_items
  end
end