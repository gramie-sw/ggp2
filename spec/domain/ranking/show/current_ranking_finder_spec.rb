describe CurrentRankingFinder do

  let(:ranking_provider) { SingleUserRankingProvider }
  let(:options) { {match_id: 7, page: 2} }
  subject { CurrentRankingFinder.new(ranking_provider) }

  describe '::create_for_single_user' do

    subject { CurrentRankingFinder }

    it 'should return CurrentRankingFinder with a injected SingleUserRankingProvider' do
        expected_current_ranking_finder = double('CurrentRankingFinder')
        CurrentRankingFinder.should_receive(:new).with(SingleUserRankingProvider).
            and_return(expected_current_ranking_finder)
        subject.create_for_single_user.should eq expected_current_ranking_finder
    end
  end

  describe '::create_for_single_user' do

    subject { CurrentRankingFinder }

    it 'should return CurrentRankingFinder with a injected AllUserRankingProvider' do
        expected_current_ranking_finder = double('CurrentRankingFinder')
        CurrentRankingFinder.should_receive(:new).with(AllUserRankingProvider).
            and_return(expected_current_ranking_finder)
        subject.create_for_all_users.should eq expected_current_ranking_finder
    end
  end

  describe '#finder' do

    context 'when no ranking for tip oder champion_tip exists' do

      it 'should return neutral RankingItem' do
        expected_neutral_ranking = double('NeutralRanking')

        Property.should_receive(:champion_tip_ranking_set_exists?).and_return(false)
        Property.should_receive(:last_tip_ranking_set_match_id).and_return(nil)
        ranking_provider.should_receive(:neutral_ranking).with(options).and_return(expected_neutral_ranking)

        subject.find(options).should be expected_neutral_ranking
      end
    end

    context 'when ranking for tips exist' do

      it 'should return the latest tip ranking' do
        expected_tip_ranking = double('TipRanking')

        Property.should_receive(:champion_tip_ranking_set_exists?).and_return(false)
        Property.should_receive(:last_tip_ranking_set_match_id).and_return(5)
        ranking_provider.should_receive(:tip_ranking).with(options.merge(match_id: 5)).and_return(expected_tip_ranking)

        subject.find(options).should be expected_tip_ranking
      end
    end

    context 'when ranking for tips and champion_tip exist' do

      it 'should return the latest tip ranking' do
        expected_champion_tip_ranking = double('ChampionTipRanking')

        Property.should_receive(:champion_tip_ranking_set_exists?).and_return(true)
        Property.should_receive(:last_tip_ranking_set_match_id).never
        ranking_provider.should_receive(:champion_tip_ranking).with(options).and_return(expected_champion_tip_ranking)

        subject.find(options).should be expected_champion_tip_ranking
      end
    end
  end
end