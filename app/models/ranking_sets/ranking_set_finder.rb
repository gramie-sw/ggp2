class RankingSetFinder


  def find_previous match_id
    previous_match_id = find_previous_ranking_set_match_id(match_id)

    if previous_match_id != 0
      create_ranking_set(previous_match_id, RankingItemQueries.all_by_match_id(previous_match_id))
    else
      create_ranking_set(0, [])
    end
  end

  def find_next_match_id match_id
    find_next_ranking_set_match_id(match_id)
  end

  private

  def ordered_match_ids
    @ordered_match_ids ||= MatchQueries.all_match_ids_ordered_by_position.to_a
  end

  def find_next_ranking_set_match_id(match_id, search_reverse: false)
    match_id_index = ordered_match_ids.index(match_id)

    if search_reverse
      highest_index = match_id.nil? ? ordered_match_ids.size : match_id_index-1
      searchable_match_ids = ordered_match_ids[0, highest_index+1].reverse
    else
      if match_id.present?
        highest_index = ordered_match_ids.size
        searchable_match_ids = ordered_match_ids[match_id_index+1, highest_index+1]
      else
        searchable_match_ids = []
      end
    end

    next_match_id = searchable_match_ids.detect do |current_match_ids|
      RankingItemQueries.exists_by_match_id?(current_match_ids)
    end

    if !search_reverse && next_match_id.nil?
      RankingItemQueries.exists_by_match_id?(nil) ? nil : 0
    else
      next_match_id
    end
  end

  def find_previous_ranking_set_match_id(match_id)
    previous_match_id = find_next_ranking_set_match_id(match_id, search_reverse: true)
    previous_match_id = 0 if previous_match_id.nil?
    previous_match_id
  end

  def create_ranking_set(match_id, ranking_items)
    RankingSet.new(match_id: match_id, ranking_items: ranking_items)
  end

end