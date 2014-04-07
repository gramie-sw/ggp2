class RankingSetUpdater

  def self.create
    RankingSetUpdater.new(
        tip_ranking_set_factory: RankingSetFactory.create_for_tip_ranking_set,
        champion_tip_ranking_set_factory: RankingSetFactory.create_for_champion_tip_ranking_set
    )
  end

  def initialize(tip_ranking_set_factory:, champion_tip_ranking_set_factory:)
    @tip_ranking_set_factory = tip_ranking_set_factory
    @champion_tip_ranking_set_factory = champion_tip_ranking_set_factory
  end

  def update_tip_ranking_set match_id, previous_ranking_item
    tips = Tip.all_by_match_id(match_id)
    update_ranking_set(match_id, tips, previous_ranking_item, tip_ranking_set_factory)
  end

  def update_champion_tip_ranking_set previous_ranking_item
    champion_tips = ChampionTip.all
    update_ranking_set(0, champion_tips, previous_ranking_item, champion_tip_ranking_set_factory)
  end

  private

  def update_ranking_set(match_id, tips, previous_ranking_item, factory)
    ranking_set = factory.build(match_id, tips, previous_ranking_item)
    ranking_set.save
    ranking_set
  end

  attr_reader :tip_ranking_set_factory, :champion_tip_ranking_set_factory

end