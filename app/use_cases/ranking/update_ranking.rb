class UpdateRanking

  def initialize
    @match_ranking_finder = MatchRankingFinder.new(Match.ordered_by_match_ids)
    @match_ranking_factory = MatchRankingFactory.new(
        ranking_item_factory: RankingItemFactory,
        ranking_item_position_service: RankingItemPositionSetter)
  end

  def run match_id

    previous_match_ranking = match_ranking_finder.find_previous(match_id)

    loop do
      previous_match_ranking = create_and_update_match_ranking(match_id, previous_match_ranking)
      match_id = match_ranking_finder.find_next_match_id(match_id)
      break if match_id.nil?
    end
  end

  private

  def create_and_update_match_ranking(match_id, previous_match_ranking)
      match_tips = Tip.all_by_match_id(match_id)
      match_ranking = match_ranking_factory.build(match_id, match_tips, previous_match_ranking)
      match_ranking.save
      match_ranking
  end

  attr_reader :match_ranking_finder, :match_ranking_factory
end