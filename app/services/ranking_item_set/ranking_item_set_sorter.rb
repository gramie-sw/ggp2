module RankingItemSetSorter
  extend self

  def sort ranking_items
    ranking_items.sort_by { |ranking_item| [-ranking_item.points, ranking_item.user.created_at]}
  end
end