module RankingItemSetSorter
  extend self

  def sort ranking_items
    ranking_items.sort_by { |ranking_item| [-ranking_item.points, -ranking_item.correct_tips_count,
                                            -ranking_item.correct_tendency_tips_only_count, ranking_item.user.created_at]}
  end
end