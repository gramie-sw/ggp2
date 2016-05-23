class TipConsecutiveMissedBadge < Badge

  def eligible_user_ids user_ids
    TipQueries.user_ids_with_at_least_result_tips(result: Tip::RESULTS[:missed], user_ids: user_ids,
                                                  count: achievement).select do |user_id|
      user_id if at_least_consecutive_missed_tips?(user_id)
    end
  end

  private

  def at_least_consecutive_missed_tips? user_id
    TipQueries.finished_match_position_ordered_results(user_id).map! { |result| result || Tip::RESULTS[:missed] }.join.include?(
        Tip::RESULTS[:missed].to_s * achievement)
  end
end