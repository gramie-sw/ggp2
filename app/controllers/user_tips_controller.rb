class UserTipsController < ApplicationController

  def show
    @presenter = UserTipsShowPresenter.new(user_id: params[:id])
  end

end
