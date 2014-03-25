class PinBoardsShowPresenter

  def comments
    @comments ||= Comment.order_by_created_at_desc.page(1)
  end

end