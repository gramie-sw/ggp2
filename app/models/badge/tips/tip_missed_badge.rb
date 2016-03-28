class TipMissedBadge < Badge

  def eligible_user_ids user_ids
    TipQueries.user_ids_with_at_least_missed_tips(user_ids: user_ids, count: achievement)
  end
end