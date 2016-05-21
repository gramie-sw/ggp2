class UserMatchPositionHistoryDataProvider

  attr_reader :user_id

  def initialize user_id
    @user_id = user_id
  end

  def provide
    match_positions = matches.map do |match|
      [match.position, user_ranking_item_by_match_id(match.id).try(:position) || player_count]
    end

    if champion_tip_ranking_item.present?
      match_positions.last[1] = champion_tip_ranking_item.position
    end

    match_positions
  end

  private

  def user_ranking_item_by_match_id(match_id)
    user_ranking_item_map[match_id]
  end

  def user_ranking_item_map
    @user_ranking_item_map ||= begin
      user_ranking_item_map = {}
      RankingItemQueries.all_by_user_id(user_id).each do |ranking_item|
        user_ranking_item_map[ranking_item.match_id] = ranking_item
      end
      user_ranking_item_map
    end
  end

  def matches
    @matches ||= MatchQueries.all_matches_with_result_ordered_by_position
  end

  def player_count
    @player_count ||= UserQueries.player_count
  end

  def champion_tip_ranking_item
    user_ranking_item_by_match_id(nil)
  end
end