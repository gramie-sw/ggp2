module AllUserRankingProvider
  extend self

  def neutral_ranking(page:)
    page = 1 if page.nil? or page==0

    users = User.players_paginated(page: page, per_page: ranking_user_page_count)

    users.each_with_index.map do |user, index|
      ranking_item = RankingItem.neutral(user_id: user.id)
      ranking_item.user = user
      ranking_item.position = index + 1 + (page-1) * ranking_user_page_count
      ranking_item
    end
  end

  def tip_ranking(match_id:, page:)
    RankingItem.query_list_ranking_set(match_id: match_id, page: page, per_page: ranking_user_page_count)
  end

  def champion_tip_ranking(page:)
    RankingItem.query_list_ranking_set(match_id: nil, page: page, per_page: ranking_user_page_count)
  end

  private

  def ranking_user_page_count
    Ggp2.config.ranking_user_page_count
  end

end