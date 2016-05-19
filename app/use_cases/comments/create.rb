module Comments
  class Create < UseCase

    attribute :user_id, Integer
    attribute :comment_attributes

    def run
      comment = Comment.create(comment_attributes.merge(user_id: user_id))

      if comment.errors.blank?
        UpdateUserBadges.run(group: :comment)
        Users::UpdateMostValuableBadge.run
      end

      comment
    end
  end
end