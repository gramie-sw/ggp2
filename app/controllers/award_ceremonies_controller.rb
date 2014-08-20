class AwardCeremoniesController < ApplicationController

  def show
    @presenter = AwardCeremoniesShowPresenter.new tournament
    FindWinnerRanking.new.run @presenter
  end
end