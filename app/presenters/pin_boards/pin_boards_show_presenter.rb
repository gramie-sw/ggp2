class PinBoardsShowPresenter

  def comments
    @comments ||= Comment.order_by_created_at_desc
  end

end