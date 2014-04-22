class MainNavLinksProvider

  include NavLinksProvidable
  include ActionView::Helpers::TranslationHelper
  include Rails.application.routes.url_helpers

  def links current_user, tournament
    links = []

    if current_user.admin?
      links << build_link(Match.model_name.human_plural, matches_path, :matches)
      links << build_link(Aggregate.model_name.human_plural, aggregates_path, :aggregates)
      links << build_link(Venue.model_name.human_plural, venues_path, :venues)
      links << build_link(User.model_name.human_plural, users_path(type: User::USER_TYPE_PLAYERS), :users)
    else
      if tournament.finished?
        links << build_link(t('general.award_ceremony'), award_ceremonies_path, :award_ceremonies)
      end
      links << build_link(Tip.model_name.human_plural, user_tip_path(current_user), :tips)
      links << build_link(t('general.ranking'), rankings_path, :rankings)
      links << build_link(t('general.pin_board'), pin_boards_path, :pin_boards)
      links << build_link(t('general.profile.one'), profile_path(current_user), :profile)
    end
  end

  #admin menu sections
  section(:aggregates).is_active_for(:aggregates)
  section(:matches).is_active_for(:matches)
  section(:venues).is_active_for(:venues)
  section(:users).is_active_for(:users)

  #player menu sections
  section(:award_ceremonies).is_active_for(:award_ceremonies)
  section(:tips).is_active_for([:user_tips, :match_tips])
  section(:rankings).is_active_for(:rankings)
  section(:pin_boards).is_active_for([:pin_boards, :comments])
  section(:profile).is_active_for(:profiles)
  section(:profile).is_active_for('adapted_devise/registrations')
end