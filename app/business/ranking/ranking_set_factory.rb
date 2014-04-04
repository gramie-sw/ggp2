class RankingSetFactory

  def self::create_for_tip_ranking_set
    RankingSetFactory.new(
        ranking_item_factory: TipRankingItemFactory,
        ranking_items_position_setter: RankingItemsPositionSetter
    )
  end

  def self::create_for_champion_tip_ranking_set
    RankingSetFactory.new(
        ranking_item_factory: ChampionTipRankingItemFactory,
        ranking_items_position_setter: RankingItemsPositionSetter
    )
  end


  def initialize(ranking_item_factory:, ranking_items_position_setter:)
    @ranking_item_factory = ranking_item_factory
    @ranking_items_position_setter = ranking_items_position_setter
  end

  def build match_id, tips, previous_ranking_item_set
    ranking_items = create_ranking_items(tips, previous_ranking_item_set)
    ranking_items_position_setter.set_positions(ranking_items)
    RankingSet.new(match_id: match_id, ranking_items: ranking_items)
  end

  private

  attr_reader :ranking_item_factory, :ranking_items_position_setter

  def create_ranking_items tips, previous_ranking_item_set
    tips.map do |tip|
      ranking_item_factory.build(tip, previous_ranking_item_set.ranking_item_of_user(tip.user_id))
    end
  end
end