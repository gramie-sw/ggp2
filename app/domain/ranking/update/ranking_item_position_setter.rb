module RankingItemPositionSetter
  extend self

  def set_positions! ranking_items
    previous_ranking_item = nil
    (sort ranking_items).map!.with_index do |ranking_item, index|
      if index == 0
        ranking_item.position = 1
      else
        set_position(ranking_item, previous_ranking_item, index)
      end
      previous_ranking_item = ranking_item
    end
  end


  private

  def sort(ranking_items)
    ranking_items.sort_by do |ranking_item|
      [
          -ranking_item.points,
          (ranking_item.correct_champion_tip? ? 0 : 1),
          -ranking_item.correct_tips_count,
          -ranking_item.correct_tendency_tips_only_count,
          ranking_item.user.created_at
      ]
    end
  end

  def set_position(ranking_item, previous_ranking_item, index)

    if ranking_item.ranking_hash == previous_ranking_item.ranking_hash
      ranking_item.position = previous_ranking_item.position
    else
      ranking_item.position = index + 1
    end
  end
end