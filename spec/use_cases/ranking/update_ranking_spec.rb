describe UpdateRanking do


  describe '#run' do

    let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }
    let(:neutral_ranking_set) { double('NeutralRankingSet1') }
    let(:tips_match_1) { double('Tips1') }
    let(:tips_match_2) { double('Tips2') }
    let(:updated_ranking_set_1) { double('UpdatedRankingSet1') }
    let(:updated_ranking_set_2) { double('UpdatedRankingSet2') }

    subject { UpdateRanking.new }

    before :each do
      expect(Match).to receive(:ordered_match_ids).and_return(ordered_match_ids)
    end

    context 'when no next RankingSet exists' do

      it 'should update RankingSet for given match_id' do
        expect_any_instance_of(TipRankingSetFinder).to receive(:find_previous).with(1).and_return(neutral_ranking_set)

        expect_any_instance_of(RankingSetUpdater).to receive(:update_tip_ranking_set).
            with(1, neutral_ranking_set).and_return(updated_ranking_set_1)

        expect_any_instance_of(TipRankingSetFinder).to receive(:find_next_match_id).with(1).and_return(nil)

        expect(Property).to receive(:set_last_tip_ranking_set_match_id_to).with(1)
        expect(Property).to receive(:set_champion_tip_ranking_set_exists_to).never

        subject.run(1)
      end
    end

    context 'when one next RankingSet exists' do

      it 'should update RankingSet for given and next match_id' do
        expect_any_instance_of(TipRankingSetFinder).to receive(:find_previous).with(1).and_return(neutral_ranking_set)

        expect_any_instance_of(RankingSetUpdater).to receive(:update_tip_ranking_set).
            with(1, neutral_ranking_set).and_return(updated_ranking_set_1)

        expect_any_instance_of(TipRankingSetFinder).to receive(:find_next_match_id).with(1).and_return(2)

        expect_any_instance_of(RankingSetUpdater).to receive(:update_tip_ranking_set).
            with(2, updated_ranking_set_1).and_return(updated_ranking_set_2)

        expect_any_instance_of(TipRankingSetFinder).to receive(:find_next_match_id).with(2).and_return(nil)

        expect_any_instance_of(RankingSetUpdater).to receive(:update_champion_tip_ranking_set).never

        expect(Property).to receive(:set_last_tip_ranking_set_match_id_to).with(2)
        expect(Property).to receive(:set_champion_tip_ranking_set_exists_to).never

        subject.run(1)
      end
    end

    context 'when last RankingSet of last Match was updated' do

      it 'should also update RankingSet of ChampionTips' do

        expect_any_instance_of(TipRankingSetFinder).to receive(:find_previous).with(7).and_return(neutral_ranking_set)

        expect_any_instance_of(RankingSetUpdater).to receive(:update_tip_ranking_set).
            with(7, neutral_ranking_set).and_return(updated_ranking_set_1)

        expect_any_instance_of(TipRankingSetFinder).to receive(:find_next_match_id).with(7).and_return(nil)

        expect_any_instance_of(RankingSetUpdater).to receive(:update_champion_tip_ranking_set).
            with(updated_ranking_set_1).and_return(updated_ranking_set_2)

        expect_any_instance_of(RankingSetUpdater).to receive(:update_champion_tip_ranking_set).never

        expect(Property).to receive(:set_last_tip_ranking_set_match_id_to).with(7)
        expect(Property).to receive(:set_champion_tip_ranking_set_exists_to).with(true)

        subject.run(7)
      end
    end
  end
end