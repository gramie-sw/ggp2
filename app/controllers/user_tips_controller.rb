class UserTipsController < ApplicationController

  def show
    @presenter = UserTipsShowPresenter.new(
        user: current_resource,
        tournament: tournament,
        user_is_current_user: is_user_current_user?(current_resource)
    )

    ShowAllTipsOfAggregateForUser.
        new(tournament: tournament, user_id: params[:id], current_aggregate_id: params[:aggregate_id]).
        run_with_presentable(@presenter)
    ShowChampionTip.new(params[:id]).run_with_presentable(@presenter)
    ShowAllPhases.new.run_with_presentable(@presenter)
  end

  private

  def current_resource
    @current_resource ||= User.find_player(params[:id]) if params[:id]
  end
end
