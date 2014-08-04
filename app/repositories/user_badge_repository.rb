module UserBadgeRepository

  extend ActiveSupport::Concern

  included do
    scope :all_by_user_id, ->(user_id) { where(user_id: user_id) }
    scope :all_by_badge_identifiers, ->(badge_identifiers) { where(badge_identifier: badge_identifiers) }
  end

  module ClassMethods

    def badges_by_user_id user_id
      identifiers = UserBadge.all_by_user_id(user_id).pluck(:badge_identifier)
      BadgeRepository.find_by_indentifiers_sorted(identifiers)
    end

    def destroy_and_create_multiple group, user_badges
      UserBadge.transaction do
        (all_by_badge_group(group).destroy_all.all? && user_badges.map(&:save).all?) || raise(ActiveRecord::Rollback)
      end
    end

    private

    def all_by_badge_group group

      badge_identifiers = UserBadge.all.pluck(:badge_identifier)
      badge_identifiers_by_group = BadgeRepository.identifiers_belong_to_group(group, badge_identifiers)
      UserBadge.all_by_badge_identifiers badge_identifiers_by_group
    end
  end
end