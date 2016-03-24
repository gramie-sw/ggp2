class CommentCreatedBadge < Badge

  def eligible_user_ids user_ids
    CommentQueries.user_ids_with_at_least_comments(user_ids: user_ids, count: achievement)
  end
end