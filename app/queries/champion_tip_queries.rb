module ChampionTipQueries

  class << self

    def clear_all_results
      ChampionTip.update_all(result: nil)
    end

    def missed_champion_tip_user_ids user_ids
      ChampionTip.where(user_id: user_ids).merge(ChampionTip.where('champion_tips.team_id IS NULL')).pluck(:user_id)
    end
  end
end