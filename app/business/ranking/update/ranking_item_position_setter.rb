module RankingItemPositionSetter
  extend self

  def set_positions ranking_items
    previous_ranking_item = nil
    (sort ranking_items).map!.with_index do |ranking_item, index|
      if index == 0
        ranking_item.position = 1
        previous_ranking_item = ranking_item
      else
        previous_ranking_item = set_position ranking_item, previous_ranking_item
      end
    end
  end


  private

  def sort ranking_items
    ranking_items.sort_by { |ranking_item| [-ranking_item.points,
                                            (ranking_item.correct_champion_tip? ? 0 : 1),
                                            -ranking_item.correct_tips_count,
                                            -ranking_item.correct_tendency_tips_only_count,
                                            ranking_item.user.created_at]
    }
  end

  def set_position ranking_item, previous_ranking_item
    ranking_item.position = previous_ranking_item.position
    ranking_item.position += 1 unless ranking_item.ranking_hash == previous_ranking_item.ranking_hash
    ranking_item
  end
end