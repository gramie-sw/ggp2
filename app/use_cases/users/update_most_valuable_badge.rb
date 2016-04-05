class Users::UpdateMostValuableBadge < UseCase

  def run
    all_player_ids = UserQueries.all_player_ids
    UserQueries.update_most_valuable_badge all_player_ids
  end
end