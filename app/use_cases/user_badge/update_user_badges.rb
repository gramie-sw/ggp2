class UpdateUserBadges

  def initialize group
    @group = group
  end

  def run

    badges =  BadgeRepository.by_group group
    new_user_badges = UserBadgeProvider.new.provide(badges)
    UserBadge.destroy_and_create_multiple(group, new_user_badges)
  end

  private

  attr_reader :group

end