module SingleUserRankingProvider
  extend self

  def neutral_ranking user_id
    RankingItem.neutral(user_id)
  end

  def tip_ranking(user_id:, match_id:)
    RankingItem.first_by_user_id_and_match_id(user_id: user_id, match_id: match_id) || neutral_ranking(user_id)
  end

  def champion_tip_ranking(user_id)
    RankingItem.first_by_user_id_and_match_id(user_id: user_id, match_id: nil) || neutral_ranking(user_id)
  end
end