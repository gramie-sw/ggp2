class UserCreateService

  Result = Struct.new(:user, :successful?)

  def initialize(match_repository:, tip_factory:)
    @match_repository = match_repository
    @tip_factory = tip_factory
  end

  def create user_attributes
    user = User.new(user_attributes)
    user.tips = tip_factory.build_all
    user.save ? successful = true : successful = false
    Result.new(user, successful)
  end

  private
  attr_reader :match_repository, :tip_factory
end