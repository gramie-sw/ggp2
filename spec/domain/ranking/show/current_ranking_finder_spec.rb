describe CurrentRankingFinder do

  let(:ranking_provider) { AllUserRankingProvider }
  let(:options) { {match_id: 7, page: 2} }
  subject { CurrentRankingFinder.new(ranking_provider) }

  describe '::create_for_all_user' do

    subject { CurrentRankingFinder }

    it 'should return CurrentRankingFinder with a injected AllUserRankingProvider' do
        expected_current_ranking_finder = double('CurrentRankingFinder')
        expect(CurrentRankingFinder).to receive(:new).with(AllUserRankingProvider).
            and_return(expected_current_ranking_finder)
        expect(subject.create_for_all_users).to eq expected_current_ranking_finder
    end
  end

  describe '#finder' do

    context 'when no ranking for tip oder champion_tip exists' do

      it 'should return neutral RankingItem' do
        expected_neutral_ranking = double('NeutralRanking')

        expect(Property).to receive(:champion_tip_ranking_set_exists?).and_return(false)
        expect(Property).to receive(:last_tip_ranking_set_match_id).and_return(nil)
        expect(ranking_provider).to receive(:neutral_ranking).with(options).and_return(expected_neutral_ranking)

        expect(subject.find(options)).to be expected_neutral_ranking
      end
    end

    context 'when ranking for tips exist' do

      it 'should return the latest tip ranking' do
        expected_tip_ranking = double('TipRanking')

        expect(Property).to receive(:champion_tip_ranking_set_exists?).and_return(false)
        expect(Property).to receive(:last_tip_ranking_set_match_id).and_return(5)
        expect(ranking_provider).to receive(:tip_ranking).with(options.merge(match_id: 5)).and_return(expected_tip_ranking)

        expect(subject.find(options)).to be expected_tip_ranking
      end
    end

    context 'when ranking for tips and champion_tip exist' do

      it 'should return the latest tip ranking' do
        expected_champion_tip_ranking = double('ChampionTipRanking')

        expect(Property).to receive(:champion_tip_ranking_set_exists?).and_return(true)
        expect(Property).to receive(:last_tip_ranking_set_match_id).never
        expect(ranking_provider).to receive(:champion_tip_ranking).with(options).and_return(expected_champion_tip_ranking)

        expect(subject.find(options)).to be expected_champion_tip_ranking
      end
    end
  end
end