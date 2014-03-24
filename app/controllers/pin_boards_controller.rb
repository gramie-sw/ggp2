class PinBoardsController < ApplicationController

  def show
    @presenter = PinBoardsShowPresenter.new
  end

end