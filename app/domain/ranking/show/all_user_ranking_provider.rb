module AllUserRankingProvider
  extend self

  def neutral_ranking(page:)
    page = page.to_i
    page = 1 if page.nil? or page==0

    users = User.players_for_ranking_listing(page: page, per_page: user_page_count)

    users.each_with_index.map do |user, index|
      ranking_item = RankingItem.neutral(user_id: user.id)
      ranking_item.user = user
      ranking_item.position = index + 1 + (page-1) * user_page_count
      ranking_item
    end
  end

  def tip_ranking(match_id:, page:)
    RankingItem.ranking_set_for_listing(match_id: match_id, page: page, per_page: user_page_count)
  end

  def champion_tip_ranking(page:)
    RankingItem.ranking_set_for_listing(match_id: nil, page: page, per_page: user_page_count)
  end

  private

  def user_page_count
    Ggp2.config.user_page_count
  end

end