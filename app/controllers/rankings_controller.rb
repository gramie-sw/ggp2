class RankingsController < ApplicationController

  def show
    @presenter = RankingsShowPresenter.new
  end
end
