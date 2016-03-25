class PinBoardsController < ApplicationController

  def show
    @presenter = PinBoardsShowPresenter.new(
        comments_repo: CommentQueries,
        page: params[:page],
        current_user_id: current_user.id,
        is_admin: current_user.admin?
    )
  end
end