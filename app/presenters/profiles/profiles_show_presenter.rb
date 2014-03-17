class ProfilesShowPresenter

  attr_reader :user, :is_for_current_user
  alias is_for_current_user? is_for_current_user

  def initialize(user:, tournament:, is_for_current_user:)
    @user = user
    @tournament = tournament
    @is_for_current_user = is_for_current_user
  end

  def user_statistic
    @user_statistic ||= UserStatistic.new(user: user, tournament: tournament)
  end

  private

  attr_reader :tournament
end