class UserTipsController < ApplicationController

  def show
    @presenter = UserTipsShowPresenter.new(
        user: User.find(params[:id]),
          user_is_current_user: params[:id] == current_user.id.to_s
    )
  end

end
