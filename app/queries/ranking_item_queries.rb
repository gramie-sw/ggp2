module RankingItemQueries

  class << self

    def find_by_user_id_and_match_id(user_id:, match_id:)
      RankingItem.where(user_id: user_id, match_id: match_id).first
    end
  end

end