class RankingsController < ApplicationController

  def show
    ranking_items = RankingSets::FindCurrent.run(page: params[:page])
    @presenter = RankingPresenter.new(
        ranking_items: ranking_items,
        tournament: tournament,
        current_user_id: current_user.id)
  end
end