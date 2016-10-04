module RankingItemQueries

  class << self

    def find_by_user_id_and_match_id(user_id:, match_id:)
      RankingItem.where(user_id: user_id, match_id: match_id).first
    end

    def all_by_match_id(match_id)
      RankingItem.where(match_id: match_id)
    end

    def all_by_user_id(user_id)
      RankingItem.where(user_id: user_id)
    end

    def exists_by_match_id?(match_id)
      RankingItem.where(match_id: match_id).exists?
    end

    def paginated_by_match_id_for_ranking_view(match_id, page: nil, per_page: nil)
      ranking_items = RankingItem.where(match_id: match_id).
          order(position: :asc, user_id: :asc).
          includes(user: {champion_tip: :team}).
          page(page).per(per_page)
    end

    def winner_ranking_items
      RankingItem.where(match_id: nil).order(position: :asc).where('position <= 3')
    end

    def destroy_and_create_multiple match_id, ranking_items

      successful = false

      RankingItem.transaction do
        successful = (RankingItem.where(match_id: match_id).destroy_all.all? && ranking_items.map(&:save).all?)
        raise(ActiveRecord::Rollback) unless successful
      end
      successful
    end

    def destroy_all_by_match_id(match_id)
      RankingItem.where(match_id: match_id).destroy_all
    end
  end

end