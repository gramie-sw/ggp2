module RankingItemFactory
  extend self

  def build_ranking_item previous_ranking_item=neutral_previous_ranking_item, tip

    ranking_item = RankingItem.new(match_id: tip.match_id,
                    user_id: tip.user_id,
                    correct_tips_count: calculate_correct_tips_count(previous_ranking_item, tip),
                    correct_tendency_tips_only_count: calculate_correct_tendency_tips_only_count(previous_ranking_item, tip))

    ranking_item.points = ranking_item.correct_tips_count + ranking_item.correct_tendency_tips_only_count
    ranking_item
  end

  private
  def calculate_correct_tips_count previous_ranking_item, tip
    Tip::RESULTS[:correct] == tip.result ? previous_ranking_item.correct_tips_count + 1 : previous_ranking_item.correct_tips_count
  end

  def calculate_correct_tendency_tips_only_count previous_ranking_item, tip
    Tip::RESULTS[:correct_tendency] == tip.result ? previous_ranking_item.correct_tendency_tips_only_count + 1 : previous_ranking_item.correct_tendency_tips_only_count
  end

  def neutral_previous_ranking_item
    RankingItem.new(correct_tips_count: 0, correct_tendency_tips_only_count: 0)
  end
end