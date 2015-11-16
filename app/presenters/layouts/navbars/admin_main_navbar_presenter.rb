class AdminMainNavbarPresenter

  include ActionView::Helpers::TranslationHelper
  include Rails.application.routes.url_helpers

  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def nav_links
    links = []

    links << NavLink.new(label: t('general.match_schedule'),
                         url: match_schedules_path,
                         is_active_for: {controller: :match_schedules},
                         params: params)

    links << NavLink.new(label: t('general.settings'),
                         url: teams_path,
                         is_active_for: {controller: [:teams, :tournament_settings]},
                         params: params)

    links << NavLink.new(label: t('general.pin_board'),
                         url: pin_boards_path,
                         is_active_for: {controller: :pin_boards},
                         params: params)

    links << NavLink.new(label: User.model_name.human_plural,
                         url: users_path(type: User::TYPES[:player]),
                         is_active_for: {controller: :users},
                         params: params)

    links << NavLink.new(label: t('general.profile.one'),
                         url: edit_user_registration_path,
                         is_active_for: {controller: :profiles},
                         params: params)

    links
  end
end