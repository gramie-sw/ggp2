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

      RankingSetFactory.
          should_receive(:create_for_tip_ranking_set).and_return(expected_tip_ranking_set_factory)
      RankingSetFactory.
          should_receive(:create_for_champion_tip_ranking_set).and_return(expected_champion_tip_ranking_set_factory)

      RankingSetUpdater.should_receive(:new).with(
          tip_ranking_set_factory: expected_tip_ranking_set_factory,
          champion_tip_ranking_set_factory: expected_champion_tip_ranking_set_factory
      )

      subject.create
    end
  end

  describe '#update_tip_ranking_set' do

    it 'should return create and saved new tip ranking_set for tips' do
      tips = double('Tips')

      Tip.should_receive(:all_by_match_id).with(3).and_return(tips)
      tip_ranking_set_factory.
          should_receive(:build).with(3, tips, previous_ranking_set).and_return(expected_ranking_set)
      expected_ranking_set.should_receive(:save)

      subject.update_tip_ranking_set(3, previous_ranking_set).should eq expected_ranking_set
    end
  end

  describe '#update_champion_tip_ranking_set' do

    it 'should create ans save new tip ranking_set for tips' do
      champion_tips = double('ChampionTips')

      ChampionTip.should_receive(:all).and_return(champion_tips)
      champion_tip_ranking_set_factory.
          should_receive(:build).with(nil, champion_tips, previous_ranking_set).and_return(expected_ranking_set)
      expected_ranking_set.should_receive(:save)

      subject.update_champion_tip_ranking_set(previous_ranking_set).should eq expected_ranking_set
    end
  end
end