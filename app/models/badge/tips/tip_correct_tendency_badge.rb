class TipCorrectTendencyBadge < Badge

  def eligible_user_ids user_ids
    TipQueries.user_ids_with_at_least_result_tips(result: results, user_ids: user_ids,
                                                  count: achievement)
  end

  def results
    [
        Tip::RESULTS[:correct_tendency_only],
        Tip::RESULTS[:correct_tendency_with_score_difference],
        Tip::RESULTS[:correct_tendency_with_one_score]
    ]
  end
end