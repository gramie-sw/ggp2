class RankingPresenter
  
  def initialize(ranking_items:, tournament:, current_user_id:)
    @tournament = tournament
    @current_user_id = current_user_id
    @ranking_items = ranking_items
  end

  def subtitle
    I18n.t('tournament.progress',
           total_match_count: tournament.total_match_count,
           played_match_count: tournament.played_match_count)
  end

  def user_ranking_presenters

    @user_ranking_presenters ||= begin
      ranking_items.map do |ranking_item|
        UserRankingPresenter.new(
            ranking_item: ranking_item,
            tournament: tournament,
            current_user_id: current_user_id
        )
      end
    end
  end

  def pagination_scope
    ranking_items
  end

  private

  attr_reader :ranking_items, :tournament, :current_user_id, :page
end