module RankingItemRepository
  extend ActiveSupport::Concern

  included do
    scope :all_by_match_id, ->(match_id) { where(match_id: match_id) }
  end

  module ClassMethods

    def exists_by_match_id? match_id
      all_by_match_id(match_id).exists?
    end

    def destroy_and_create_multiple match_id, ranking_items

      RankingItem.transaction do
        (RankingItem.destroy_all(match_id: match_id).all? && ranking_items.map(&:save).all?) || raise(ActiveRecord::Rollback)
      end
    end
  end
end