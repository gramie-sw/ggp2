class ProfilesController < ApplicationController

  def show
    user = User.find_player(params[:id])
    @presenter = ProfilesShowPresenter.new(user: user,
                                           tournament: tournament,
                                           is_for_current_user: is_user_current_user?(user),
                                           section: params[:section])
  end

end
