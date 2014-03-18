class ProfilesShowPresenter

  attr_reader :user, :is_for_current_user
  alias is_for_current_user? is_for_current_user

  def initialize(user:, tournament:, is_for_current_user:, section: nil)
    @user = user
    @tournament = tournament
    @is_for_current_user = is_for_current_user
    @section = section.try(:to_sym)
  end

  def user_statistic
    @user_statistic ||= UserStatistic.new(user: user, tournament: tournament)
  end

  def current_section
    if available_sections.include?(@section)
      @section
    else
      @available_sections.first
    end
  end

  def available_sections
    @available_sections ||= [:statistic, :badges, :user_data]
  end

  private

  attr_reader :tournament
end