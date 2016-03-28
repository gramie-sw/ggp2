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

  def update_tip_ranking_set match_id, previous_ranking_set
    tips = TipQueries.all_by_match_id(match_id)
    update_ranking_set(match_id, tips, previous_ranking_set, tip_ranking_set_factory)
  end

  def update_champion_tip_ranking_set previous_ranking_set
    champion_tips = ChampionTip.all
    update_ranking_set(nil, champion_tips, previous_ranking_set, champion_tip_ranking_set_factory)
  end

  private

  def update_ranking_set(match_id, tips, previous_ranking_set, factory)
    ranking_set = factory.build(match_id, tips, previous_ranking_set)
    ranking_set.save
    ranking_set
  end

  attr_reader :tip_ranking_set_factory, :champion_tip_ranking_set_factory

end