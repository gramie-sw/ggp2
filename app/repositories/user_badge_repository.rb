module UserBadgeRepository

  extend ActiveSupport::Concern

  included do
    scope :all_by_group, ->(group) { where(group: group) }
  end
end