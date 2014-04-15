class ShowWinnerRanking

  def run presenter
    finder = WinnerRankingFinder.new
    presenter.first_places = finder.find_first_places
    presenter.second_places = finder.find_second_places
    presenter.third_places = finder.find_third_places
  end
end