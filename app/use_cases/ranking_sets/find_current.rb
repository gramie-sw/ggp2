module RankingSets
  class FindCurrent < UseCase

    attribute :page, Integer

    def initialize(params={})
      super(params)
      # We set default value to 1, because we use the page value to calculate the position for neutral RankingItems.
      # We cannot use default option von Virtus attribute-method to achieve the same,
      # because this would not be uses when page with value nil is given
      @page = 1 if page.nil? || page == 0
    end

    def run

      # We can unify this code with RankingItems::FindCurrentForUser
      if ::Property.champion_tip_ranking_set_exists?
        ranking_by_match_id(nil)
      else

        match_id = ::Property.last_tip_ranking_set_match_id

        if match_id.nil?
          neutral_ranking
        else
          ranking_by_match_id(match_id)
        end
      end

    end

    private

    def neutral_ranking
      users = ::UserQueries.paginated_for_ranking_view(page: page, per_page: per_page)

      ranking_items = users.each_with_index.map do |user, index|
        ranking_item = ::RankingItem.neutral(user_id: user.id)
        ranking_item.user = user
        ranking_item.position = index + 1 + (page-1) * per_page
        ranking_item
      end

      Kaminari.paginate_array(ranking_items, total_count: UserQueries.player_count).page(page).per(per_page)
    end

    def ranking_by_match_id(match_id)
      RankingItemQueries.paginated_by_match_id_for_ranking_view(match_id, page: page, per_page: per_page)
    end

    def per_page
      Ggp2.config.user_page_count
    end
  end
end