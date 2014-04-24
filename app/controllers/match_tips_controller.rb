class MatchTipsController < ApplicationController

  def show
    @presenter = MatchTipsShowPresenter.new(
        match: Match.find(params[:id]),
        current_user_id: current_user.id,
        page: params[:page]
    )
  end
end
