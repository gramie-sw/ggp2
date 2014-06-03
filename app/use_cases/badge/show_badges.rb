class ShowBadges

  def run presenter
    presenter.groups = BadgeRepository.groups
    presenter.grouped_badges = Ggp2.config.badge_registry.grouped_badges
  end
end