class RootsController < ApplicationController

  def show

    if current_user.admin?
      redirect_to matches_path
    elsif current_user.player?
      if tournament.finished?
        redirect_to award_ceremonies_path
      else
        redirect_to user_tip_path(current_user)
      end
    end
  end
end