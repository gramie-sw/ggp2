module RankingItemSetPositionSetter
  extend self

  def set_positions ranking_item_set
    previous_ranking_item = RankingItem.neutral
    (sort ranking_item_set).map! do |ranking_item|
      previous_ranking_item = set_position ranking_item, previous_ranking_item
    end

  end

  private

  def sort ranking_item_set
    ranking_item_set.sort_by { |ranking_item| [-ranking_item.points, -ranking_item.correct_tips_count,
                                            -ranking_item.correct_tendency_tips_only_count, ranking_item.user.created_at]}
  end

  def set_position ranking_item, previous_ranking_item


  end
end