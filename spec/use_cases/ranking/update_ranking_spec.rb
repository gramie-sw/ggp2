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
      Match.should_receive(:ordered_by_match_ids).and_return(ordered_match_ids)
    end

    context 'when no next RankingSet exists' do

      it 'should update RankingSet for given match_id' do
        TipRankingSetFinder.any_instance.should_receive(:find_previous).with(1).and_return(neutral_ranking_set)

        RankingSetUpdater.
            any_instance.should_receive(:update_tip_ranking_set).
            with(1, neutral_ranking_set).and_return(updated_ranking_set_1)

        TipRankingSetFinder.any_instance.should_receive(:find_next_match_id).with(1).and_return(nil)

        subject.run(1)
      end
    end

    context 'when one next RankingSet exists' do

      it 'should update RankingSet for given and next match_id' do
        TipRankingSetFinder.any_instance.should_receive(:find_previous).with(1).and_return(neutral_ranking_set)

        RankingSetUpdater.
            any_instance.should_receive(:update_tip_ranking_set).
            with(1, neutral_ranking_set).and_return(updated_ranking_set_1)

        TipRankingSetFinder.any_instance.should_receive(:find_next_match_id).with(1).and_return(2)

        RankingSetUpdater.
            any_instance.should_receive(:update_tip_ranking_set).
            with(2, updated_ranking_set_1).and_return(updated_ranking_set_2)

        TipRankingSetFinder.any_instance.should_receive(:find_next_match_id).with(2).and_return(nil)

        RankingSetUpdater.any_instance.should_receive(:update_champion_tip_ranking_set).never

        subject.run(1)
      end
    end

    context 'when last RankingSet of last Match was updated' do

      it 'should also update RankingSet of ChampionTips' do

        TipRankingSetFinder.any_instance.should_receive(:find_previous).with(7).and_return(neutral_ranking_set)

        RankingSetUpdater.
            any_instance.should_receive(:update_tip_ranking_set).
            with(7, neutral_ranking_set).and_return(updated_ranking_set_1)

        TipRankingSetFinder.any_instance.should_receive(:find_next_match_id).with(7).and_return(nil)

        RankingSetUpdater.
            any_instance.should_receive(:update_champion_tip_ranking_set).
            with(updated_ranking_set_1).and_return(updated_ranking_set_2)

        RankingSetUpdater.any_instance.should_receive(:update_champion_tip_ranking_set).never
        
        subject.run(7)
      end
    end
  end
end