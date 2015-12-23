module UserBadgeRepository

  # extend ActiveSupport::Concern
  #
  # included do
  #   scope :all_by_badge_identifiers, ->(badge_identifiers) { where(badge_identifier: badge_identifiers) }
  # end
  #
  # module ClassMethods
  #
  #   def all_by_user_id user_id
  #     UserBadge.where(user_id: user_id)
  #   end
  #
  #   def destroy_and_create_multiple group, user_badges
  #     UserBadge.transaction do
  #       (all_by_badge_group(group).destroy_all.all? && user_badges.map(&:save).all?) || raise(ActiveRecord::Rollback)
  #     end
  #   end
  #
  #   private
  #
  #   def all_by_badge_group group
  #
  #     badge_identifiers = UserBadge.all.pluck(:badge_identifier)
  #     badge_identifiers_by_group = BadgeRepository.identifiers_belong_to_group(group, badge_identifiers)
  #     UserBadge.all_by_badge_identifiers badge_identifiers_by_group
  #   end
  # end
end