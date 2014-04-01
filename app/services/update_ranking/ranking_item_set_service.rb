class RankingItemSetService

  def initialize(ranking_item_repository:)
    @ranking_item_repository = ranking_item_repository
  end

  def previous_ranking_item_set current_match_id, ordered_match_ids
    previous_match_ids = ordered_match_ids[0, ordered_match_ids.index(current_match_id)]
    match_id = find_next_ranking_item_set_match_id previous_match_ids.reverse

    if match_id
      create_ranking_item_set(match_id, ranking_item_repository.ranking_items_by_match_id(match_id))
    end
  end

  def previous_or_neutral_ranking_item_set current_match_id, ordered_match_ids
    previous_ranking_item_set(current_match_id, ordered_match_ids) || neutral_ranking_item_set
  end

  def next_ranking_item_set_match_id current_match_id, ordered_match_ids
    next_ordered_match_ids = ordered_match_ids[ordered_match_ids.index(current_match_id)+1, ordered_match_ids.size-1]
    find_next_ranking_item_set_match_id(next_ordered_match_ids)
  end

  def save_ranking_item_set ranking_item_set
    ranking_item_repository.update_multiple(ranking_item_set.match_id, ranking_item_set.ranking_items)
  end

  def neutral_ranking_item_set
    create_ranking_item_set(0, [])
  end

  private

  attr_reader :ranking_item_repository

  def find_next_ranking_item_set_match_id ordered_match_ids
    ordered_match_ids.detect do |match_id|
      ranking_item_repository.exists_by_match_id?(match_id)
    end
  end

  def create_ranking_item_set(match_id, ranking_items)
    RankingItemSet.new(match_id: match_id, ranking_items: ranking_items)
  end
end