class ShowBadges

  def run presenter
    presenter.groups = BadgeRepository.groups
    presenter.grouped_badges = BadgeRepository.badges_sorted_grouped
  end
end