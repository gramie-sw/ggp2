describe RankingSetUpdater do

  let(:rip_ranking_set_factory) { TipRankingSetFactory.create_for_tip_ranking_set  }
  let(:champion_tip_ranking_set_factory) { TipRankingSetFactory.create_for_champion_tip_ranking_set }

  subject { RankingSetUpdater.new(tip_ranking_set_factory: tip_ranking_set_factory) }
end