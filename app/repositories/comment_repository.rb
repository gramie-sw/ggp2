module CommentRepository
  extend ActiveSupport::Concern

  included do
    scope :group_by_user_with_at_least_comments, ->(count) do
      select(:user_id).group(:user_id).having("count(user_id) >= ?", count)
    end
  end

  module ClassMethods

    def user_ids_with_at_least_comments count
      group_by_user_with_at_least_comments(count).pluck(:user_id)
    end

    def user_ids_ordered_by_creation_desc
      order_by_created_at_desc.pluck(:user_id)
    end

    def user_ids_grouped
      select(:user_id).group(:user_id).pluck(:user_id)
    end
  end
end