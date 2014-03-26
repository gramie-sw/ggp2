class RankingItemSet

  def initialize(match: match, match_ids: match_ids)
    @match = match
    @match_ids = match_ids
  end

  def successor_ranking_item_set
    create_following_ranking_item_set successor_match_ids
  end

  def predecessor_ranking_item_set
    create_following_ranking_item_set predecessor_match_ids
  end

  def successor_ranking_items
    find_following_ranking_items successor_match_ids
  end

  def predecessor_ranking_items
    find_following_ranking_items predecessor_match_ids
  end

  def ranking_items match_id= match.id
    RankingItem.where(match_id: match_id)
  end

  def build_ranking_items
    concrete_predecessor_ranking_items = predecessor_ranking_items
    Tip.where(match_id: match.id).map do |tip|
      predecessor_ranking_item = concrete_predecessor_ranking_items.select { |ranking_item| ranking_item.user.id == tip.user.id }.first
      predecessor_ranking_item.present? ? ::RankingItemFactory.build_ranking_item(predecessor_ranking_item, tip) : ::RankingItemFactory.build_ranking_item(tip)
    end
  end

  def destroy_ranking_items
    RankingItem.destroy_all(match: match)
  end

  def destroy_existing_and_save_built_ranking_items build_ranking_items
    RankingItem.transaction do
      RankingItem.destroy_all(match: match)
      build_ranking_items.each(&:save!)
    end
  end

  private

  attr_reader :match, :match_ids

  def ranking_items? match_id= match.id
    ranking_items(match_id).present?
  end

  def create_following_ranking_item_set successor_match_ids
    match_id = following_match_id_which_has_ranking_items successor_match_ids
    if match_id
      RankingItemSet.new match: Match.find(match_id), match_ids: match_ids
    end
  end

  def find_following_ranking_items certain_match_ids
    certain_match_ids.detect do |match_id|
      following_ranking_items = ranking_items match_id
      break following_ranking_items if following_ranking_items.present?
    end
  end

  def following_match_id_which_has_ranking_items certain_match_ids
    certain_match_ids.detect do |match_id|
      ranking_items? match_id
    end
  end

  def successor_match_ids
    # plus one because we don't want to have the current match_id in the returning array
    match_ids.drop(match_ids.index(match.id) + 1)
  end

#previous match_ids beginning with the closest to the current match_id
  def predecessor_match_ids
    match_ids.take(match_ids.index(match.id)).reverse
  end
end