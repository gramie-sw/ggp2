class TipBadge < Badge

  attribute :result, String

  def group_identifier
    super result
  end

  def eligible_user_ids user_ids
    Tip.user_ids_with_at_least_result_tips(result: Tip::RESULTS[result.to_sym], user_ids: user_ids, count: achievement)
  end
end