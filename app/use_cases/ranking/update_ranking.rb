class UpdateRanking

  def initialize
    @ranking_set_finder = TipRankingSetFinder.new(Match.ordered_by_match_ids)
    @ranking_set_factory = RankingSetFactory.new(
        ranking_item_factory: TipRankingItemFactory,
        ranking_items_position_setter: RankingItemPositionSetter)
  end

  def run match_id

    previous_ranking_set = ranking_set_finder.find_previous(match_id)

    loop do
      previous_ranking_set = create_and_update_ranking_set(match_id, previous_ranking_set)
      match_id = ranking_set_finder.find_next_match_id(match_id)
      break if match_id.nil?
    end
  end

  private

  def create_and_update_ranking_set(match_id, previous_ranking_set)
      match_tips = Tip.all_by_match_id(match_id)
      ranking_set = ranking_set_factory.build(match_id, match_tips, previous_ranking_set)
      ranking_set.save
      ranking_set
  end

  attr_reader :ranking_set_finder, :ranking_set_factory
end