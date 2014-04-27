module CommentRepository
  extend ActiveSupport::Concern

  included do
    scope :user_ids_with_at_least_comments, ->(count) do
      select(:user_id).group(:user_id).having("count(user_id) >= ?", count)
    end
  end
end