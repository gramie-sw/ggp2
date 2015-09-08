module Rankings
  class FindCurrentForUser < FindCurrentBase

    attribute :user_id, Integer

    private

    def neutral_ranking
      RankingItem.neutral(user_id)
    end

    def ranking_by_match_id(match_id)
      ::RankingItemQueries.find_by_user_id_and_match_id(user_id: user_id, match_id: match_id) || neutral_ranking
    end
  end
end