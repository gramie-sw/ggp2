module MatchResults
  class Update < UseCase

    attribute :match_id, Integer
    attribute :match_result_attributes

    def run

      match_result = MatchResult.new(match_result_attributes.merge(match_id: match_id))

      if match_result.save

        set_tip_results
        set_champion_tip_results_if_necessary
        update_ranking_sets
        update_user_badges

      end

      match_result
    end

    private

    def set_tip_results
      Tips::SetResults.run(match_id: match_id)
    end

    def set_champion_tip_results_if_necessary
      champion_team = Tournament.new.champion_team

      if champion_team.present?
        ChampionTips::SetResults.run(champion_team_id: champion_team.id)
      end
    end

    def update_ranking_sets
      RankingSets::Update.run(match_id: match_id)
    end

    def update_user_badges
      UpdateUserBadges.run(group: :tip)
    end
  end
end