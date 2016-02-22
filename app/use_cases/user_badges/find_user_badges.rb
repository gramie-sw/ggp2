class FindUserBadges < UseCase

  attribute :user_id

  def run
    BadgeRepository.badges_by_user_id user_id, :desc
  end
end