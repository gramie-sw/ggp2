class RankingItemSet

  def initialize(match: match)
    @match = match
  end


  def next_ranking_item_set

  end

  def previous_ranking_item_set
    previous_match_ids.detect do |previous_match_id|
      RankingItem.ranking_items(previous_match_id)
    end
  end

  def create
    User.players.map do |player|
      RankingItem.new(user: player, match: match)
    end
  end

  def destroy
    RankingItem.destroy_all(match: @match)
  end

  private
  def next_match_ids
    # plus one because we don't want to have the current match_id in the returning array
    match_ids.drop(match_ids.index(@match.id) + 1)
  end

  #previous match_ids beginning with the closest to the current match_id
  def previous_match_ids
    match_ids.take(match_ids.index(@match.id)).reverse
  end

  def match_ids
    @match_ids ||= Match.order_by_position.pluck(:id)
  end
end