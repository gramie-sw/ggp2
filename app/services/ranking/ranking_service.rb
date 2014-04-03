class RankingService

  attr_reader :match

  def initialize(match: match)
    @match = match
  end

  def ranking_item_set
    @ranking_item_set ||= RankingSet.new match: match, ordered_match_ids: Match.ordered_match_ids
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
    updateable_ranking_item_set = build(process_ranking_item_set)
    #Property.save_last_result_match_id match_id
    process_ranking_item_set.update(updateable_ranking_item_set)
    #Property.save_last_result_match_id match_idq
  end

  def build process_ranking_item_set
    RankingItemsPositionSetter.set_positions process_ranking_item_set.build_ranking_items
  end
end