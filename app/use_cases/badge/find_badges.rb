class FindBadges

  Result = Struct.new(:groups, :grouped_badges)

  def run
    result = Result.new
    result.groups= BadgeRepository.groups
    result.grouped_badges= BadgeRepository.badges_sorted_grouped
    result
  end
end