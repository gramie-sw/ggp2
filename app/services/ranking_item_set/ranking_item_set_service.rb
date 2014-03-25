class RankingItemSetService

  def initialize(match: match)
    @match = match
    @ranking_item_set = RankingItemSet.new match: @match, match_ids: Match.match_ids
  end

  def update_ranking_items
    begin
      @ranking_item_set.destroy_ranking_items
      save_ranking_items(RankingItemsPositionSetter.set_positions @ranking_item_set.create_ranking_items)
      @ranking_item_set = @ranking_item_set.next_ranking_item_set
    end while @ranking_item_set
  end

  private

  def save_ranking_items ranking_items
    RankingItem.transaction do
      ranking_items.each(&:save!)
    end
  end
end