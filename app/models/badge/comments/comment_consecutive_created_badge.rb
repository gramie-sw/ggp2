class CommentConsecutiveCreatedBadge < Badge

  def eligible_user_ids user_ids
    joined_user_ids = Comment.user_ids_ordered_by_creation_desc.join(',')

    user_ids.select do |user_id|
      expected_user_id_sequence = Array.new(achievement) {user_id}.join(',')
      user_id if joined_user_ids.match(/(^|,)#{expected_user_id_sequence}/)
    end
  end
end