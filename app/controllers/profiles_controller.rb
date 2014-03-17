class ProfilesController < ApplicationController

  def show
    user = User.find_player(params[:id])
    is_for_current_user = permission_service.is_user_current_user?(user)
    @presenter = ProfilesShowPresenter.new(user: user, tournament: tournament, is_for_current_user: is_for_current_user)
  end

end
