module Comments
  class Delete < UseCase

    attribute :id, Integer

    def run
      Comment.destroy(id)
      UpdateUserBadges.run(group: :comment)
      Users::UpdateMostValuableBadge.run
    end
  end
end