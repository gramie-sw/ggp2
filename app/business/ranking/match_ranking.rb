class MatchRanking

  attr_reader :match_id, :ranking_items

  def initialize(match_id:, ranking_items:)
    @match_id = match_id
    @ranking_items = ranking_items
  end

  def ranking_item_of_user(user_id)
    user_id_to_ranking_item_map(user_id)
  end

  def neutral?
    match_id == 0 && ranking_items.blank?
  end

  def save
    RankingItem.update_multiple(match_id, ranking_items)
  end

  private

  def user_id_to_ranking_item_map(user_id)

    if @user_id_to_ranking_item_map.present?
      @user_id_to_ranking_item_map[user_id] || RankingItem.neutral
    else
      @user_id_to_ranking_item_map = {}
      ranking_items.each { |ranking_item| @user_id_to_ranking_item_map[ranking_item.user_id] = ranking_item }
      user_id_to_ranking_item_map(user_id)
    end
  end
end