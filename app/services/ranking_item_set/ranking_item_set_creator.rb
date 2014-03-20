class RankingItemSetCreator

  def initialize(match: match, match_ids: match_ids)
    @match = match
    @match_ids = match_ids
  end

  def next_ranking_item_set
    find_next_ranking_item_set next_match_ids
  end

  def previous_ranking_item_set
    find_next_ranking_item_set previous_match_ids
  end

  #def create
  #  prev_ranking_item_set = previous_ranking_item_set
  #  User.players.map do |player|
  #    tip = Tip.find(user_id: player.id, match_id: @match.id)
  #    previous_ranking_item = prev_ranking_item_set.select { |ranking_item| ranking_item.user.id == player.id }.first
  #    previous_ranking_item.present? ? RankingItemFactory.build_ranking_item(previous_ranking_item, tip) : RankingItemFactory.build_ranking_item(tip)
  #  end
  #  #previous_ranking_item_set.map do |previous_ranking_item|
  #  #  tip = Tip.find(user_id: previous_ranking_item.user.id, match_id: @match.id)
  #  #  RankingItemFactory.build_ranking_item previous_ranking_item, tip
  #  #end
  #end

  def destroy
    RankingItem.destroy_all(@match)
  end

  private
  def find_next_ranking_item_set(match_ids)
    match_id = match_ids.detect do |match_id|
      RankingItem.by_match_id(match_id).exists?
    end
    RankingItem.by_match_id(match_id)
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