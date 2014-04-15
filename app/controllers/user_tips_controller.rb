class UserTipsController < ApplicationController

  def show

    @presenter = UserTipsShowPresenter.new(
        user: current_resource,
        tournament: Tournament.new,
        user_is_current_user: params[:id] == current_user.id.to_s
    )
  end

  private

  def current_resource
    @current_resource ||= User.find_player(params[:id]) if params[:id]
  end
end
