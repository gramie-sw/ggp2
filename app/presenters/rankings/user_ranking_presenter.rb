class UserRankingPresenter

  delegate :nickname,
           to: :user
  delegate :user_id,
           :position,
           :points,
           :correct_tips_count,
           :correct_tendency_tips_only_count,
           to: :ranking_item

  def initialize ranking_item: ranking_item, tournament: tournment, current_user_id: current_user_id
    @ranking_item = ranking_item
    @tournament = tournament
    @current_user_id = current_user_id
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
        user.champion_tip.team.abbreviation
      else
        nil
    end
  end

  private

  attr_reader :ranking_item, :tournament, :current_user_id

  #TODO refactor
  #desicions should be done by permission service
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