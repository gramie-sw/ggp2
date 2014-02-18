class TipsController < ApplicationController

  def edit_multiple
    @presenter = TipsEditMultiplePresenter.new(params[:tip_ids])
  end

  def update_multiple
  end
end
