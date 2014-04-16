class AwardCeremoniesController < ApplicationController

  def show
    @presenter = AwardCeremoniesShowPresenter.new tournament
    ShowWinnerRanking.new.run @presenter
  end
end