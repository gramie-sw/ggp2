class UserTipsController < ApplicationController

  def show

    current_aggregate = Aggregates::FindOrFindCurrentPhase.run(id: params[:aggregate_id])

    @presenter = UserTipsPresenter.new(
        user: current_resource,
        current_aggregate: current_aggregate,
        tournament: tournament,
        user_is_current_user: is_user_current_user?(current_resource)
    )

    session[Ggp2::USER_TIPS_LAST_SHOWN_AGGREGATE_ID_KEY] = params[:aggregate_id]
  end

  private

  def current_resource
    @current_resource ||= User.find_player(params[:id]) if params[:id]
  end
end
