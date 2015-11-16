class UserMainNavbarPresenter

  include ActionView::Helpers::TranslationHelper
  include Rails.application.routes.url_helpers

  attr_reader :params, :current_user, :tournament

  def initialize(params:, current_user:, tournament:)
    @params = params
    @current_user = current_user
    @tournament = tournament
  end

  def nav_links
    links = []

    if tournament.finished?
      links << NavLink.new(label: t('general.award_ceremony'),
                           url: award_ceremonies_path,
                           is_active_for: {controller: :award_ceremonies},
                           params: params)
    end

    links << NavLink.new(label: Tip.model_name.human_plural,
                         url: user_tip_path(current_user),
                         is_active_for: {controller: [:user_tips, :match_tips]},
                         params: params)

    links << NavLink.new(label: t('general.ranking'),
                         url: rankings_path,
                         is_active_for: {controller: :rankings},
                         params: params)

    links << NavLink.new(label: t('general.pin_board'),
                         url: pin_boards_path,
                         is_active_for: {controller: [:pin_boards, :comments]},
                         params: params)

    links << NavLink.new(label: t('general.profile.one'),
                         url: profile_path(current_user),
                         is_active_for: {controller: [:profiles, 'adapted_devise/registrations']},
                         params: params)

    links
  end
end