class TipChampionMissedBadge < Badge

  def eligible_user_ids user_ids
    Tournament.new.started? ? ChampionTipQueries.missed_champion_tip_user_ids(user_ids) : []
  end
end