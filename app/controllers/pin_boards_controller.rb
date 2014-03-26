class PinBoardsController < ApplicationController

  def show
    @presenter = PinBoardsShowPresenter.new(
        comments_repo: Comment,
        page: params[:page],
        current_user_id: current_user.id
    )
  end

end