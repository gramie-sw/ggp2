module ChampionTipRankingItemFactory
  extend self

  def build champion_tip, previous_ranking_item

    attributes = {
        user_id: previous_ranking_item.user_id,
        points: previous_ranking_item.points,
        correct_tips_count: previous_ranking_item.correct_tips_count,
        correct_tendeny_tips_count: previous_ranking_item.correct_tendeny_tips_count,
        correct_champion_tip: previous_ranking_item.correct_champion_tip
    }

    if champion_tip.result?
      attributes.merge!(
          points: previous_ranking_item.points + Ggp2.config.correct_champion_tip_points,
          correct_champion_tip: true
      )
    end

    RankingItem.new(attributes)
  end

end