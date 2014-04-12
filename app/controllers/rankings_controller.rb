class RankingsController < ApplicationController

  def show
    @presenter = RankingsShowPresenter.new(tournament: tournament, current_user_id: current_user.id, page: params[:page])
    ShowAllUserCurrentRanking.new.run(@presenter, params[:page])
  end
end
