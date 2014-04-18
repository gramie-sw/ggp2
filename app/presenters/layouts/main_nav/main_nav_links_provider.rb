class MainNavLinksProvider

  include NavLinksProvidable
  include ActionView::Helpers::TranslationHelper
  include Rails.application.routes.url_helpers

  def links current_user
    links = []
    links << build_link(t('general.award_ceremony'), award_ceremonies_path, :award_ceremonies)
    links << build_link(Tip.model_name.human_plural, user_tip_path(current_user), :tips)
    links << build_link(t('general.ranking'), rankings_path, :rankings)
    links << build_link(t('general.pin_board'), pin_boards_path, :pin_boards)
    links << build_link(t('general.profile.one'), profile_path(current_user), :profile)
  end
end