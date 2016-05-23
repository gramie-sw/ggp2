class TipConsecutiveCorrectTendencyBadge < Badge

  def eligible_user_ids user_ids

    TipQueries.user_ids_with_at_least_result_tips(result: results, user_ids: user_ids,
                                                  count: achievement).select do |user_id|
      user_id if at_least_consecutive_correct_tendency_tips?(user_id)
    end
  end

  private

  def at_least_consecutive_correct_tendency_tips? user_id
    results_string = TipQueries.finished_match_position_ordered_results(user_id).map! { |result|
      result || Tip::RESULTS[:missed]
    }.join

    /[#{results.join}]{#{achievement},}/.match(results_string)

  end

  def results
    [
        Tip::RESULTS[:correct_tendency_only],
        Tip::RESULTS[:correct_tendency_with_score_difference],
        Tip::RESULTS[:correct_tendency_with_one_score]
    ]
  end
end