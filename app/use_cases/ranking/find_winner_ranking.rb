class FindWinnerRanking

  Result = Struct.new(:first_places, :second_places, :third_places)

  def run
    finder = WinnerRankingFinder.new

    result = Result.new
    result.first_places=  finder.find_first_places
    result.second_places = finder.find_second_places
    result.third_places = finder.find_third_places
    result
  end
end