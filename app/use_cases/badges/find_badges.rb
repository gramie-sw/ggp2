class FindBadges < UseCase

  Result = Struct.new(:groups, :grouped_badges)

  def run
    result = Result.new
    result.groups= BadgeRepository.groups
    result.grouped_badges= BadgeRepository.grouped_badges
    result
  end
end