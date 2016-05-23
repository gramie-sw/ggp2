class TipConsecutiveBadge < Badge

  attribute :result, String

  def group_identifier
    super result
  end

  def eligible_user_ids user_ids
    TipQueries.user_ids_with_at_least_result_tips(result: Tip::RESULTS[result.to_sym], user_ids: user_ids,
                                           count: achievement).select do |user_id|
      user_id if at_least_consecutive_results?(TipQueries.match_position_ordered_results(user_id), Tip::RESULTS[result.to_sym].to_s)
    end
  end

  private

  def at_least_consecutive_results? ordered_user_results, result
    ordered_user_results.map! { |value| value || Tip::RESULTS[:missed] }.join.include?(result * achievement)
  end
end