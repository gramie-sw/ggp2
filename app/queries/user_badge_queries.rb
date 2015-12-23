module UserBadgeQueries

  class << self

    def badge_group_identifiers_distinct
      UserBadge.select(:badge_group_identifier).distinct.pluck(:badge_group_identifier)
    end

    def all_by_badge_group_identifiers badge_group_identifiers
      UserBadge.where(badge_group_identifier: badge_group_identifiers)
    end

    def all_by_user_id user_id
      UserBadge.where(user_id: user_id)
    end

    def destroy_and_create_multiple group, user_badges
      UserBadge.transaction do
        (all_by_badge_group(group).destroy_all.all? && user_badges.map(&:save).all?) || raise(ActiveRecord::Rollback)
      end
    end

    def all_by_badge_group group
      badge_group_identifiers = UserBadgeQueries.badge_group_identifiers_distinct
      badge_group_identifiers_by_group = BadgeRepository.group_identifiers_belong_to_group(group, badge_group_identifiers)
      UserBadgeQueries.all_by_badge_group_identifiers badge_group_identifiers_by_group
    end
  end
end