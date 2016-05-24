module MatchResults
  class Delete < UseCase

    attribute :match_id, Integer

    def run
      match = Match.find(match_id)

      Match.transaction do
        match.clear_result
        match.save

        TipQueries.clear_all_results_by_match_id(match_id)
        ChampionTipQueries.clear_all_results

        RankingSets::Delete.run(match_id: match_id)
        UpdateUserBadges.run(group: :tip)
        Users::UpdateMostValuableBadge.run
      end
    end
  end
end