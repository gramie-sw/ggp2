describe UpdateRanking do


  describe '#run' do

    let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }
    let(:neutral_ranking_set) { double('NeutralMatchRanking1') }
    let(:tips_match_1) { double('Tips1') }
    let(:tips_match_2) { double('Tips2') }
    let(:ranking_set_1) { double('MatchRanking1') }
    let(:ranking_set_2) { double('MatchRanking2') }

    subject { UpdateRanking.new }

    before :each do
      Match.should_receive(:ordered_by_match_ids).and_return(ordered_match_ids)

      Tip.should_receive(:all_by_match_id).with(1).and_return(tips_match_1)
      TipRankingSetFinder.any_instance.should_receive(:find_previous).with(1).and_return(neutral_ranking_set)
      RankingSetFactory.any_instance.
          should_receive(:build).with(1, tips_match_1, neutral_ranking_set).and_return(ranking_set_1)

      ranking_set_1.should_receive(:save).ordered

    end

    context 'when no next MatchRanking exists' do

      it 'should create and save MatchRanking for given match_id' do
        TipRankingSetFinder.any_instance.should_receive(:find_next_match_id).with(1).and_return(nil)

        subject.run(1)
      end
    end

    context 'when one next MatchRanking exists' do


      it 'should create and save MatchRankings for given and next match_id' do
        TipRankingSetFinder.any_instance.should_receive(:find_next_match_id).with(1).and_return(2)

        Tip.should_receive(:all_by_match_id).with(2).and_return(tips_match_2)
        RankingSetFactory.any_instance.
            should_receive(:build).with(2, tips_match_2, ranking_set_1).and_return(ranking_set_2)

        ranking_set_2.should_receive(:save).ordered

        TipRankingSetFinder.any_instance.should_receive(:find_next_match_id).with(2).and_return(nil)

        subject.run(1)
      end
    end
  end
end