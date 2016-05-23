module TipQueries

  class << self

    def all_by_match_id match_id
      Tip.where(match_id: match_id)
    end

    # Returns all tips recursively for given user_id and aggregate_id.
    # Includes matches with team_1 and team_2.
    def all_eager_by_user_id_and_aggregate_id_ordered_by_position(user_id, aggregate_id, order: 'matches.id')
      aggregate = Aggregate.find(aggregate_id)
      aggregate_ids = aggregate.has_groups? ? aggregate.groups.pluck(:id) : aggregate_id

      Tip.includes(match: [:team_1, :team_2]).
          where('tips.user_id' => user_id, 'matches.aggregate_id' => aggregate_ids).
          order(order)
    end

    def clear_all_results_by_match_id(match_id)
      Tip.where(match_id: match_id).update_all(result: nil)
    end

    def group_by_user_with_at_least_tips(count)
      Tip.select(:user_id).group(:user_id).having("count(user_id) >= ?", count)
    end

    def finished_match_position_ordered_results user_id
      Tip.where(user_id: user_id).merge(tips_with_finished_match).merge(order_by_match_position).pluck(:result)
    end

    def match_position_ordered_results user_id
      Tip.where(user_id: user_id).merge(order_by_match_position).pluck(:result)
    end

    def missed_tips
      Tip.where('tips.score_team_1 IS NULL AND tips.score_team_2 IS NULL').merge(tips_with_finished_match)
    end

    def order_by_match_position
      Tip.joins(:match).order('matches.position').references(:matches)
    end

    def order_by_match_position_by_given_ids tip_ids
      Tip.where(id: tip_ids).merge(order_by_match_position)
    end

    def tips_with_finished_match
      Tip.joins(:match).where('matches.score_team_1 IS NOT NULL AND matches.score_team_2 IS NOT NULL')
    end

    def user_ids_with_at_least_result_tips(result:, user_ids:, count:)
      Tip.where(user_id: user_ids, result: result).merge(group_by_user_with_at_least_tips(count)).pluck(:user_id)
    end
  end
end