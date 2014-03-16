class ProfilesShowPresenter

  attr_reader :user

  def initialize(user:, current_user_id:)
    @user = user
    @current_user_id = current_user_id
  end

  def user_statistic
    @user_statistic ||= UserStatistic.new(user: user, tournament: Tournament.new)
  end
end