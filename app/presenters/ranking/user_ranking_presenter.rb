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
    champion_tip_team.present? ? champion_tip_team.name : '***'
  end

  private

  attr_reader :ranking_item, :tournament, :current_user_id

  #TODO refactor
  #desicions should be done by permission service
  def champion_tip_team
    @champion_tip_team ||= begin
      if (ranking_item.user_id == current_user_id)
        user.champion_tip.team
      else
        user.champion_tip.team if tournament.started?
      end
    end
  end

  def user
    ranking_item.user
  end
end