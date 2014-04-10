class ShowAllUserCurrentRanking

  def run page
    CurrentRankingFinder.create_for_all_users.find(page: page)
  end
end