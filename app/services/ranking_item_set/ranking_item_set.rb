class RankingItemSet

  def initialize(match: match, match_ids: match_ids)
    @match = match
    @match_ids = match_ids
  end

  #returns nil if no ranking items exists for the following match ids
  def next_ranking_item_set
    create_following_ranking_item_set next_match_ids
  end

  #returns nil if no ranking items exists for the following match ids
  def previous_ranking_item_set
    create_following_ranking_item_set previous_match_ids
  end

  def next_ranking_items
    find_following_ranking_items next_match_ids
  end

  def previous_ranking_items
    find_following_ranking_items previous_match_ids
  end

  def ranking_items match_id= @match.id
    RankingItem.where(match_id: match_id)
  end

  def create_ranking_items
    prev_ranking_item_set = previous_ranking_items
    Tip.where(match_id: @match.id).map do |tip|
      previous_ranking_item = prev_ranking_item_set.select { |ranking_item| ranking_item.user.id == tip.user.id }.first
      previous_ranking_item.present? ? ::RankingItemFactory.build_ranking_item(previous_ranking_item, tip) : ::RankingItemFactory.build_ranking_item(tip)
    end
  end

  def destroy_ranking_items
    RankingItem.destroy_all(match: @match)
  end

  private

  def ranking_items? match_id= @match.id
    ranking_items(match_id).present?
  end

  def create_following_ranking_item_set match_ids
    match_id = following_match_id_which_has_ranking_items match_ids
    if match_id
      RankingItemSet.new match: Match.find(match_id), match_ids: @match_ids
    end
  end

  def find_following_ranking_items match_ids
    match_ids.detect do |match_id|
      next_ranking_items = ranking_items match_id
      break next_ranking_items if next_ranking_items.present?
    end
  end

  def following_match_id_which_has_ranking_items match_ids
    match_ids.detect do |match_id|
      ranking_items? match_id
    end
  end

  def next_match_ids
    # plus one because we don't want to have the current match_id in the returning array
    @match_ids.drop(@match_ids.index(@match.id) + 1)
  end

#previous match_ids beginning with the closest to the current match_id
  def previous_match_ids
    @match_ids.take(@match_ids.index(@match.id)).reverse
  end
end