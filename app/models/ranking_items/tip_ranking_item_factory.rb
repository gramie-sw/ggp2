module TipRankingItemFactory
  extend self

  def build tip, previous_ranking_item

    ranking_item = RankingItem.new(
        match_id: tip.match_id,
        user_id: tip.user_id,
        correct_tips_count: calculate_correct_tips_count(tip, previous_ranking_item),
        correct_tendeny_tips_count: calculate_correct_tendeny_tips_count(tip, previous_ranking_item))
    ranking_item.points = calculate_points(tip, previous_ranking_item)
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

  def calculate_correct_tendeny_tips_count tip, previous_ranking_item
    if [Tip::RESULTS[:correct_tendency_only],
        Tip::RESULTS[:correct_tendency_with_score_difference],
        Tip::RESULTS[:correct_tendency_with_one_score]].include?(tip.result)
      previous_ranking_item.correct_tendeny_tips_count + 1
    else
      previous_ranking_item.correct_tendeny_tips_count
    end
  end

  def calculate_points(tip, previous_ranking_item)
    tip.points + previous_ranking_item.points
  end
end