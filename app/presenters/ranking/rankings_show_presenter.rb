class RankingsShowPresenter

  attr_accessor :ranking_items

  def initialize(tournament:, current_user_id:, page:)
    @tournament = tournament
    @current_user_id = current_user_id
    @page = page
    @ranking_items = []
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

  #TODO refactor
  #uc ShowAllUserCurrentRanking sets sometimes an Array of neutral RankingItems
  #in this case we have no pagination scope and have to provide our own
  def pagination_scope
    if ranking_items.instance_of?(Array)
      User.players_paginated(page: page, per_page: Ggp2.config.ranking_user_page_count)
    else
      ranking_items
    end
  end

  private

  attr_reader :tournament, :current_user_id, :page
end