class UpdateRanking

  def run match_id

    ordered_match_ids = Match.ordered_match_ids

    ranking_set_finder = TipRankingSetFinder.new(ordered_match_ids)
    ranking_set_updater = RankingSetUpdater.create

    previous_ranking_set = ranking_set_finder.find_previous(match_id)
    last_updated_match_id = 0

    loop do
      previous_ranking_set = ranking_set_updater.update_tip_ranking_set(match_id, previous_ranking_set)
      last_updated_match_id = match_id
      match_id = ranking_set_finder.find_next_match_id(match_id)
      break if match_id.nil?
    end

    Property.set_last_tip_ranking_set_match_id_to(last_updated_match_id)

    if last_updated_match_id == ordered_match_ids.last
      ranking_set_updater.update_champion_tip_ranking_set(previous_ranking_set)
      Property.set_champion_tip_ranking_set_exists_to(true)
    end
  end

  private

  attr_reader :ranking_set_finder, :ranking_set_factory
end