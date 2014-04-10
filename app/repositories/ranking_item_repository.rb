module RankingItemRepository
  extend ActiveSupport::Concern

  included do
    scope :all_by_match_id, ->(match_id) { where(match_id: match_id) }
    scope :all_by_user_id_and_match_id, ->(user_id: user_id, match_id: match_id) do
      where(user_id: user_id, match_id: match_id)
    end
    scope :ordered_by_position_asc, -> { order(position: :asc) }

    scope :query_list_ranking_set, ->(match_id: match_id, page: page, per_page:) do
      where(match_id: match_id).ordered_by_position_asc.includes(:user).page(page).per(per_page)
    end
  end

  module ClassMethods

    def first_by_user_id_and_match_id(user_id: user_id, match_id: match_id)
      all_by_user_id_and_match_id(user_id: user_id, match_id: match_id).first
    end

    def exists_by_match_id? match_id
      all_by_match_id(match_id).exists?
    end

    def destroy_and_create_multiple match_id, ranking_items
      #TODO check transaction
      RankingItem.transaction do
        (RankingItem.destroy_all(match_id: match_id).all? && ranking_items.map(&:save).all?) || raise(ActiveRecord::Rollback)
      end
    end
  end
end