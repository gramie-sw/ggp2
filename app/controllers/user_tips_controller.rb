class UserTipsController < ApplicationController

  def show
    @presenter = UserTipsShowPresenter.new(
        user: current_resource,
        tournament: tournament,
        user_is_current_user: is_user_current_user?(current_resource)
    )

    #TODO should be tested through feature tests
    session[Ggp2::USER_TIPS_LAST_SHOWN_CURRENT_AGGREGATE_ID_KEY] = params[:aggregate_id]

    ShowAllTipsOfAggregateForUser.
        new(tournament: tournament,
            user_id: params[:id],
            current_aggregate_id: params[:aggregate_id],
            sort: current_user.match_sort).
        run_with_presentable(@presenter)
    @presenter.champion_tip = FindChampionTip.new(params[:id]).run
    ShowAllPhases.new.run_with_presentable(@presenter)
  end

  private

  def current_resource
    @current_resource ||= User.find_player(params[:id]) if params[:id]
  end
end
