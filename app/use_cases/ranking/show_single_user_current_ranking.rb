class ShowSingleUserCurrentRanking

  def run user_id
    CurrentRankingFinder.create_for_single_user.find(user_id: user_id)
  end
end