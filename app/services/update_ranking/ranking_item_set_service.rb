class RankingItemSetService

  def initialize(ranking_item_repository:)
    @ranking_item_repository = ranking_item_repository
  end

  def previous_ranking_item_set current_match_id, ordered_match_ids
    previous_match_ids = ordered_match_ids[0, ordered_match_ids.index(current_match_id)]
    find_next_ranking_item_set previous_match_ids.reverse
  end

  def previous_or_neutral_ranking_item_set current_match_id, ordered_match_ids
    previous_ranking_item_set(current_match_id, ordered_match_ids) || neutral_ranking_item_set
  end

  def next_ranking_item_set next_match_ids
    #Todo should get complete ordered match_ids
    find_next_ranking_item_set next_match_ids
  end

  def save_ranking_item_set ranking_item_set
    ranking_item_repository.update_multiple(ranking_item_set.match_id, ranking_item_set.ranking_items)
  end

  def neutral_ranking_item_set
    create_ranking_item_set(0, [])
  end

  private

  attr_reader :ranking_item_repository

  def find_next_ranking_item_set match_ids
    match_id = next_match_id_with_ranking_items match_ids

    if match_id
      create_ranking_item_set(match_id, ranking_item_repository.ranking_items_by_match_id(match_id))
    end
  end

  def next_match_id_with_ranking_items match_ids
    match_ids.detect do |match_id|
      ranking_item_repository.ranking_items_by_match_id(match_id).size != 0
    end
  end

  def create_ranking_item_set(match_id, ranking_items)
    RankingItemSet.new(match_id: match_id, ranking_items: ranking_items)
  end
end