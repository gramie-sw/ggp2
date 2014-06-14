class PinBoardsShowPresenter

  attr_reader :is_admin

  def initialize(comments_repo:, page:, current_user_id:, is_admin:)
    @comments_repo = comments_repo
    @page = page
    @current_user_id = current_user_id
    @is_admin = is_admin
  end

  def comment_presenters
    @comment_presenters ||= comments.map do |comment|
      CommentsPresenter.new(comment: comment, is_for_current_user: comment.user_id == current_user_id, is_admin: is_admin)
    end
  end

  def comments
    @comments ||= comments_repo.comments_for_pin_board(page)
  end

  private

  attr_reader :page, :comments_repo, :current_user_id
end