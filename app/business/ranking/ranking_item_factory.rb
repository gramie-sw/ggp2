module RankingItemFactory
  extend self

  def build tip, previous_ranking_item

    ranking_item = RankingItem.new(
        match_id: tip.match_id,
        user_id: tip.user_id,
        correct_tips_count: calculate_correct_tips_count(tip, previous_ranking_item),
        correct_tendency_tips_only_count: calculate_correct_tendency_tips_only_count(tip, previous_ranking_item))
    ranking_item.points = calculate_points ranking_item.correct_tips_count, ranking_item.correct_tendency_tips_only_count
    ranking_item
  end

  private

  def calculate_correct_tips_count tip, previous_ranking_item
    if Tip::RESULTS[:correct] == tip.result
      previous_ranking_item.correct_tips_count + 1
    else
      previous_ranking_item.correct_tips_count
    end
  end

  def calculate_correct_tendency_tips_only_count tip, previous_ranking_item
    if Tip::RESULTS[:correct_tendency] == tip.result
      previous_ranking_item.correct_tendency_tips_only_count + 1
    else
      previous_ranking_item.correct_tendency_tips_only_count
    end
  end

  def calculate_points correct_tips_count, correct_tendency_tips_only_count
    correct_tips_count * Ggp2.config.correct_tip_points +
        correct_tendency_tips_only_count * Ggp2.config.correct_tendency_tip_only_points
  end
end