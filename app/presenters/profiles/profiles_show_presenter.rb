class ProfilesShowPresenter

  attr_reader :user, :is_for_current_user
  alias is_for_current_user? is_for_current_user

  def initialize(user:, tournament:, is_for_current_user:, section: nil)
    @user = user
    @tournament = tournament
    @is_for_current_user = is_for_current_user
    @section = section.try(:to_sym)
  end

  def title
    if is_for_current_user
      I18n.t('profile.yours')
    else
      I18n.t('general.profile.one')
    end
  end

  def subtitle
    if is_for_current_user
      ''
    else
      I18n.t('general.of_subject', subject: user.nickname)
    end
  end

  def user_statistic
    @user_statistic ||= begin
      current_ranking_item = ShowSingleUserCurrentRanking.new.run(user.id)
      UserStatistic.new(user: user, tournament: tournament, current_ranking_item: current_ranking_item)
    end
  end

  def current_section
    if available_sections.include?(@section)
      @section
    else
      @available_sections.first
    end
  end

  def available_sections
    @available_sections ||= [:statistic, :badge, :user_data]
  end

  private

  attr_reader :tournament
end