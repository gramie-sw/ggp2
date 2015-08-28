module Ranking
  class FindCurrentForAllUsers < FindCurrentBase

    # we set default value to 1, because we use the page value to calculate the position for neutral RankingItems
    attribute :page, Integer, default: 1

    private

    def neutral_ranking
      users = ::UserQueries.all_for_ranking(page: page, per_page: per_page)

      users.each_with_index.map do |user, index|
        ranking_item = ::RankingItem.neutral(user_id: user.id)
        ranking_item.user = user
        ranking_item.position = index + 1 + (page-1) * per_page
        ranking_item
      end
    end

    def ranking_by_match_id(match_id)
      RankingItemQueries.ranking_set_for_ranking_view_by_match_id(match_id, page: page, per_page: per_page)
    end

    def per_page
      Ggp2.config.user_page_count
    end
  end
end