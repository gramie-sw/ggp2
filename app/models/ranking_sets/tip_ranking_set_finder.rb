class TipRankingSetFinder

  def find_previous(match_id)
    match_id = find_next_ranking_set_match_id(match_id, reverse_search: true)

    if match_id
      create_ranking_set(match_id, RankingItemQueries.all_by_match_id(match_id))
    else
      create_ranking_set(0, [])
    end
  end

  def find_next_match_id(match_id)
    find_next_ranking_set_match_id(match_id)
  end

  def find_previous_match_id(match_id)
    find_next_ranking_set_match_id(match_id, reverse_search: true)
  end

  def exists_next?(match_id)
    find_next_ranking_set_match_id(match_id).present?
  end

  def exists_for_last_match?
    RankingItemQueries.exists_by_match_id?(ordered_match_ids.last)
  end

  private

  def ordered_match_ids
    @ordered_match_ids ||= MatchQueries.all_match_ids_ordered_by_position.to_a
  end

  def find_next_ranking_set_match_id(match_id, reverse_search: false)

    match_id_index = ordered_match_ids.index(match_id)

    if reverse_search
      match_ids_to_search_through = ordered_match_ids[0, match_id_index].reverse
    else
      match_ids_to_search_through = ordered_match_ids[match_id_index + 1, ordered_match_ids.size]
    end

    match_ids_to_search_through.detect do |match_id|
      RankingItemQueries.exists_by_match_id?(match_id)
    end
  end

  def create_ranking_set(match_id, ranking_items)
    RankingSet.new(match_id: match_id, ranking_items: ranking_items)
  end
end