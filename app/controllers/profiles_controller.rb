class ProfilesController < ApplicationController

  def show
    @presenter = ProfilesShowPresenter.new(user: User.find_player(params[:id]),
                                           current_user_id: current_user.id)
  end

end
