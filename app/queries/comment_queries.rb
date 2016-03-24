module CommentQueries

  class << self

    def all_by_user_ids(user_ids)
      Comment.where(user_id: user_ids)
    end

    def group_by_user_with_at_least_comments(count)
      Comment.select(:user_id).group(:user_id).having('count(user_id) >= ?', count)
    end

    def comments_for_pin_board(page)
      order_by_created_at_desc.includes(:user).page(page).per(10)
    end

    def order_by_created_at_desc
      Comment.order(created_at: :desc)
    end

    def user_ids_grouped
      Comment.select(:user_id).group(:user_id).pluck(:user_id)
    end

    def user_ids_ordered_by_creation_desc
      order_by_created_at_desc.pluck(:user_id)
    end

    def user_ids_with_at_least_comments(user_ids:, count:)
      all_by_user_ids(user_ids).select(:user_id).group(:user_id).having('count(user_id) >= ?', count).pluck(:user_id)
    end
  end
end
