class AwardCeremoniesController < ApplicationController

  def show
    @presenter = AwardCeremoniesShowPresenter.new
    ShowWinnerRanking.new.run @presenter
  end
end