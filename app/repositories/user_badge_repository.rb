module UserBadgeRepository

  extend ActiveSupport::Concern

  included do
    scope :all_by_group, ->(group) { where(group: group) }
    scope :all_by_user_id, ->(user_id) { where(user_id: user_id)}
    scope :order_by_position, -> { order('position ASC') }
  end

  module ClassMethods

    def destroy_and_create_multiple group, user_badges
      UserBadge.transaction do
        (UserBadge.destroy_all(group: group).all? && user_badges.map(&:save).all?) || raise(ActiveRecord::Rollback)
      end
    end
  end
end