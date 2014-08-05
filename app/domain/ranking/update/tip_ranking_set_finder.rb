class TipRankingSetFinder

  def initialize ordered_match_ids
    @ordered_match_ids = ordered_match_ids
  end

  def find_previous current_match_id
    previous_match_ids = ordered_match_ids[0, ordered_match_ids.index(current_match_id)]
    match_id = find_next_ranking_set_match_id previous_match_ids.reverse

    if match_id
      create_ranking_set(match_id, RankingItem.all_by_match_id(match_id))
    else
      create_ranking_set(0, [])
    end
  end

  def find_next_match_id current_match_id
    next_ordered_match_ids = ordered_match_ids[ordered_match_ids.index(current_match_id)+1, ordered_match_ids.size-1]
    find_next_ranking_set_match_id(next_ordered_match_ids)
  end

  private

  attr_reader :ordered_match_ids

  def find_next_ranking_set_match_id ordered_match_ids
    ordered_match_ids.detect do |match_id|
      RankingItem.exists_by_match_id?(match_id)
    end
  end

  def create_ranking_set(match_id, ranking_items)
    RankingSet.new(match_id: match_id, ranking_items: ranking_items)
  end
end