describe RankingSetUpdater do

  let(:champion_tip_ranking_set_factory) { RankingSetFactory.create_for_champion_tip_ranking_set }
  let(:tip_ranking_set_factory) { RankingSetFactory.create_for_tip_ranking_set }
  let(:expected_ranking_set) { RankingSet.new(match_id: nil, ranking_items: nil) }
  let(:previous_ranking_set) { RankingSet.new(match_id: nil, ranking_items: nil) }

  subject do
    RankingSetUpdater.new(
        tip_ranking_set_factory: tip_ranking_set_factory,
        champion_tip_ranking_set_factory: champion_tip_ranking_set_factory)
  end

  describe '::create' do

    subject { RankingSetUpdater }

    it 'should return correctly instantiated RankingSetUpdater' do
      expected_tip_ranking_set_factory = double('TipRankingSetFactory')
      expected_champion_tip_ranking_set_factory = double('ChampionTipRankingSetFactory')

      expect(RankingSetFactory).
          to receive(:create_for_tip_ranking_set).and_return(expected_tip_ranking_set_factory)
      expect(RankingSetFactory).
          to receive(:create_for_champion_tip_ranking_set).and_return(expected_champion_tip_ranking_set_factory)

      expect(RankingSetUpdater).to receive(:new).with(
          tip_ranking_set_factory: expected_tip_ranking_set_factory,
          champion_tip_ranking_set_factory: expected_champion_tip_ranking_set_factory
      )

      subject.create
    end
  end

  describe '#update_tip_ranking_set' do

    it 'should return create and saved new tip ranking_set for tips' do
      tips = double('Tips')

      expect(TipQueries).to receive(:all_by_match_id).with(3).and_return(tips)
      expect(tip_ranking_set_factory).
          to receive(:build).with(3, tips, previous_ranking_set).and_return(expected_ranking_set)
      expect(expected_ranking_set).to receive(:save)

      expect(subject.update_tip_ranking_set(3, previous_ranking_set)).to eq expected_ranking_set
    end
  end

  describe '#update_champion_tip_ranking_set' do

    it 'should create ans save new tip ranking_set for tips' do
      champion_tips = double('ChampionTips')

      expect(ChampionTip).to receive(:all).and_return(champion_tips)
      expect(champion_tip_ranking_set_factory).
          to receive(:build).with(nil, champion_tips, previous_ranking_set).and_return(expected_ranking_set)
      expect(expected_ranking_set).to receive(:save)

      expect(subject.update_champion_tip_ranking_set(previous_ranking_set)).to eq expected_ranking_set
    end
  end
end