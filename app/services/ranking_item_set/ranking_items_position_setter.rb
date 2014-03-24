module RankingItemsPositionSetter
  extend self

  def set_positions ranking_items
    previous_ranking_item = RankingItem.neutral
    (sort ranking_items).map! do |ranking_item|
      previous_ranking_item = set_position ranking_item, previous_ranking_item
    end
  end

  private

  def sort ranking_items
    ranking_items.sort_by { |ranking_item| [-ranking_item.points, -ranking_item.correct_tips_count,
                                            -ranking_item.correct_tendency_tips_only_count, ranking_item.user.created_at]}
  end

  def set_position ranking_item, previous_ranking_item
    if previous_ranking_item.points == ranking_item.points and previous_ranking_item.correct_tips_count == ranking_item.correct_tips_count and previous_ranking_item.correct_tendency_tips_only_count == ranking_item.correct_tendency_tips_only_count and previous_ranking_item.position != 0
      ranking_item.position= previous_ranking_item.position
    else
      ranking_item.position= previous_ranking_item.position + 1
    end
    ranking_item
  end
end