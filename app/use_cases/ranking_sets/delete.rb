module RankingSets
  class Delete < UseCase

    attribute :match_id

    def run
      ::RankingItemQueries.destroy_all_by_match_id(match_id)

      # We always delete ChampionTip-RankingSet because it makes no sense to have one
      # if we not all Tip-RankingSets present
      ::RankingItemQueries.destroy_all_by_match_id(nil)
      ::Property.set_champion_tip_ranking_set_exists_to(false)

      tip_ranking_set_finder = ::TipRankingSetFinder.new
      next_match_id = tip_ranking_set_finder.find_next_match_id(match_id)

      if next_match_id.present?
        ::Rankings::Update.run(match_id: next_match_id)
      else
        previous_match_id = tip_ranking_set_finder.find_previous_match_id(match_id)
        ::Property.set_last_tip_ranking_set_match_id_to(previous_match_id)
      end
    end
  end
end