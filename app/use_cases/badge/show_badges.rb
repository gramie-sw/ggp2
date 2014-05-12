class ShowBadges

  def run presenter
    presenter.groups = BadgeRepository.groups
    presenter.grouped_badges = Ggp2.config.badges_registry_instance.grouped_badges
  end
end