class UserRankingPresenter

  NEUTRAL_BADGE_ICON = 'fa-close'
  NEUTRAL_BADGE_COLOR = 'lightgrey'


  delegate :nickname,
           :full_name,
           :badges_count,
           :titleholder?,
           to: :user
  delegate :user_id,
           :position,
           :points,
           :correct_tips_count,
           :correct_tendency_tips_count,
           to: :ranking_item

  def initialize ranking_item:, tournament:, current_user_id:
    @ranking_item = ranking_item
    @tournament = tournament
    @current_user_id = current_user_id
  end

  def champion_label
    champion_tip_team_display_state == :show ? tournament.champion_title : ''
  end

  def champion_tip_team_name

    case champion_tip_team_display_state
      when :show
        user.champion_tip.team.name
      when :hide
        '***'
      else
        I18n.t('tip.not_present')
    end
  end

  def champion_tip_team_abbreviation

    case champion_tip_team_display_state
      when :show
        user.champion_tip.team.team_code
      else
        nil
    end
  end

  def badge_color
    user.most_valuable_badge ? user.most_valuable_badge.color : NEUTRAL_BADGE_COLOR
  end

  def badge_icon
    user.most_valuable_badge ? user.most_valuable_badge.icon : NEUTRAL_BADGE_ICON
  end

  def badge_title
    user.most_valuable_badge ? I18n.t("#{user.most_valuable_badge.identifier}.name") : I18n.t('badges.none')
  end

  private

  attr_reader :ranking_item, :tournament, :current_user_id

  #TODO refactor
  #decisions should be done by permission service
  def champion_tip_team_display_state
    @champion_tip_team_display_state ||= begin

      if user.champion_tip.team.present?
        if (ranking_item.user_id == current_user_id) or tournament.started?
          :show
        else
          :hide
        end
      else
        :not_present
      end
    end
  end

  def user
    ranking_item.user
  end
end