class TipConsecutiveMissedBadge < Badge

  def eligible_user_ids user_ids
    Tip.user_ids_with_at_least_missed_tips(user_ids: user_ids, count: achievement).select do |user_id|
      user_id if at_least_consecutive_missed_tips?(user_id)
    end
  end

  private

  def at_least_consecutive_missed_tips? user_id
    Tip.ordered_results_having_finished_match_by_user_id(user_id).map! { |value| value || Tip::MISSED }.join.include?(
        Tip::MISSED.to_s * achievement)
  end
end