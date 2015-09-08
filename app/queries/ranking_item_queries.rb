module RankingItemQueries

  class << self

    def find_by_user_id_and_match_id(user_id:, match_id:)
      RankingItem.where(user_id: user_id, match_id: match_id).first
    end

    def all_by_match_id(match_id)
      RankingItem.where(match_id: match_id)
    end

    def exists_by_match_id?(match_id)
      RankingItem.where(match_id: match_id).exists?
    end

    def ranking_set_for_ranking_view_by_match_id(match_id, page: nil, per_page: nil, positions: nil)
      ranking_items = RankingItem.where(match_id: match_id).
          order(position: :asc).includes(user: {champion_tip: :team}).page(page).per(per_page)

      if positions.present?
        ranking_items.where(position: positions)
      else
        ranking_items
      end
    end

    def destroy_and_create_multiple match_id, ranking_items

      successful = false

      RankingItem.transaction do
        successful = (RankingItem.destroy_all(match_id: match_id).all? && ranking_items.map(&:save).all?)
        raise(ActiveRecord::Rollback) unless successful
      end
      successful
    end
  end

end