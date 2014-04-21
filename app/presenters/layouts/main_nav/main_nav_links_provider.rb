class MainNavLinksProvider

  include NavLinksProvidable
  include ActionView::Helpers::TranslationHelper
  include Rails.application.routes.url_helpers

  def links current_user, tournament
    links = []
    if tournament.finished?
      links << build_link(t('general.award_ceremony'), award_ceremonies_path, :award_ceremonies)
    end
    links << build_link(Tip.model_name.human_plural, user_tip_path(current_user), :tips)
    links << build_link(t('general.ranking'), rankings_path, :rankings)
    links << build_link(t('general.pin_board'), pin_boards_path, :pin_boards)
    links << build_link(t('general.profile.one'), profile_path(current_user), :profile)
  end

  #player menu sections
  section(:award_ceremonies).is_active_for(:award_ceremonies)
  section(:tips).is_active_for([:user_tips, :match_tips])
  section(:rankings).is_active_for(:rankings)
  section(:pin_boards).is_active_for([:pin_boards, :comments])
  section(:profile).is_active_for(:profiles)
  section(:profile).is_active_for('adapted_devise/registrations')
end