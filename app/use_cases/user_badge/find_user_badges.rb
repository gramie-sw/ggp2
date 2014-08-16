class FindUserBadges

  def initialize user_id
    @user_id = user_id
  end

  def run
    UserBadge.badges_by_user_id(user_id)
  end

  attr_reader :user_id

end