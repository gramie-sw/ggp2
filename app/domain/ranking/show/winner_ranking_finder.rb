class WinnerRankingFinder

  def find_first_places
    find_ranking_items_with_position 1
  end

  def find_second_places
    find_ranking_items_with_position 2
  end

  def find_third_places
    find_ranking_items_with_position 3
  end

  private

  def find_ranking_items_with_position position
    winner_ranking_items.select { |ranking_item| ranking_item.position == position }
  end

  def winner_ranking_items
    @winner_ranking_items ||= RankingItem.ranking_set_for_listing_by_positions(positions: [1, 2, 3])
  end
end