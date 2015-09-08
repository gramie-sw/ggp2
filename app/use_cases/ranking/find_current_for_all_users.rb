module Ranking
  class FindCurrentForAllUsers < FindCurrentBase

    attribute :page, Integer

    def initialize(params={})
      super(params)
      # We set default value to 1, because we use the page value to calculate the position for neutral RankingItems.
      # We cannot use default option von Virtus attribute-method to achieve the same,
      # because this would not be uses when page with value nil is given
      @page = 1 if page.nil? || page == 0
    end

    private

    def neutral_ranking
      users = ::UserQueries.all_for_ranking_view(page: page, per_page: per_page)

      ranking_items = users.each_with_index.map do |user, index|
        ranking_item = ::RankingItem.neutral(user_id: user.id)
        ranking_item.user = user
        ranking_item.position = index + 1 + (page-1) * per_page
        ranking_item
      end

      Kaminari.paginate_array(ranking_items, total_count: UserQueries.player_count).page(page).per(per_page)
    end

    def ranking_by_match_id(match_id)
      RankingItemQueries.ranking_set_for_ranking_view_by_match_id(match_id, page: page, per_page: per_page)
    end

    def per_page
      Ggp2.config.user_page_count
    end
  end
end