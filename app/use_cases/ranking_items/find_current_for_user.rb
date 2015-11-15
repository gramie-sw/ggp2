module RankingItems
  class FindCurrentForUser < UseCase

    attribute :user_id, Integer

    def run

      # We can unify this code with RankingSets::FindCurrent

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
      RankingItem.neutral(user_id)
    end

    def ranking_by_match_id(match_id)
      ::RankingItemQueries.find_by_user_id_and_match_id(user_id: user_id, match_id: match_id) || neutral_ranking
    end
  end
end