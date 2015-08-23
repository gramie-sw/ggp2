class RankingsController < ApplicationController

  def show
    @presenter = RankingsShowPresenter.new(tournament: tournament, current_user_id: current_user.id, page: params[:page])
    @presenter.ranking_items = Ranking::FindCurrentForAllUsers.run(page: params[:page])
  end
end
