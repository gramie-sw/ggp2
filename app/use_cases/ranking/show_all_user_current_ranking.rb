class ShowAllUserCurrentRanking

  def run presenter, page
    presenter.ranking_items = CurrentRankingFinder.create_for_all_users.find(page: page)
  end
end