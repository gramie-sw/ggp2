module AllUserRankingProvider
  extend self

  def neutral_ranking(page:)
    page = 1 if page.nil? or page==0

    users = User.players_paginated(page)

    users.each_with_index.map do |user, index|
      ranking_item = RankingItem.neutral(user_id: user.id)
      ranking_item.user = user
      ranking_item.position = index + 1 + (page-1) * Ggp2.config.ranking_user_page_count
      ranking_item
    end
  end
end