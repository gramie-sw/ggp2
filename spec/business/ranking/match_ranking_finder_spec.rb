describe MatchRankingFinder do

  let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }
  subject { MatchRankingFinder.new(ordered_match_ids) }

  describe '#find_previous' do

    context 'when there are previous RankingItems for current_match_id' do

      it 'should return created RankingItemSet' do
        expected_ranking_items = [RankingItem.new(match_id: 3)]

        RankingItem.stub(:exists_by_match_id?).with(4).and_return(false)
        RankingItem.stub(:exists_by_match_id?).with(3).and_return(true)
        RankingItem.stub(:ranking_items_by_match_id).with(3).ordered.and_return(expected_ranking_items)

        actual_match_ranking = subject.find_previous(5)
        actual_match_ranking.should be_an_instance_of MatchRanking
        actual_match_ranking.match_id.should be 3
        actual_match_ranking.send(:ranking_items).should eq expected_ranking_items
      end
    end

    context 'when there are no previous RankingItems for current_match_id' do


      it 'should return RankingItemSet with match_id 0 and no RankingItems' do
        RankingItem.stub(:exists_by_match_id?).with(2).and_return(false)
        RankingItem.stub(:exists_by_match_id?).with(1).and_return(false)

        actual_match_ranking = subject.find_previous(3)
        actual_match_ranking.should be_an_instance_of MatchRanking
        actual_match_ranking.should be_neutral
      end
    end

    context 'when current_match_id belongs to first macht' do

      it 'should return RankingItemSet with match_id 0 and no RankingItems' do
        RankingItem.stub(:exists_by_match_id?).with(2).and_return(false)
        RankingItem.stub(:exists_by_match_id?).with(1).and_return(false)

        actual_match_ranking = subject.find_previous(3)
        actual_match_ranking.should be_an_instance_of MatchRanking
        actual_match_ranking.should be_neutral
      end
    end
  end

  describe '#find_next_match_id' do

    context 'when there are next RankingItems for match id' do

      it 'should return created RankingItemSet' do
        RankingItem.stub(:exists_by_match_id?).with(5).and_return(false)
        RankingItem.stub(:exists_by_match_id?).with(6).and_return(true)

        subject.find_next_match_id(4).should eq 6
      end
    end

    context 'when there are no next RankingItems for match id' do

      it 'should return nil' do
        RankingItem.stub(:exists_by_match_id?).with(6).and_return(false)
        RankingItem.stub(:exists_by_match_id?).with(7).and_return(false)

        subject.find_next_match_id(5).should be_nil
      end
    end

    context 'when current_match_id belongs to last macht' do

      it 'should return nil' do
        RankingItem.stub(:exists_by_match_id?).never
        subject.find_next_match_id(7).should be_nil
      end
    end
  end

end