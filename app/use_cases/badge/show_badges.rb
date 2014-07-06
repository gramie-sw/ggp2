class ShowBadges

  def run presenter
    presenter.groups = BadgeRepository.groups
    presenter.grouped_badges = BadgeRegistry.instance.grouped_badges
  end
end