describe TipRankingSetFinder do

  let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }
  subject { TipRankingSetFinder.new(ordered_match_ids) }

  describe '#find_previous' do

    context 'when there are previous RankingItems for current_match_id' do

      it 'should return created RankingItemSet' do
        expected_ranking_items = [RankingItem.new(match_id: 3)]

        expect(RankingItemQueries).to respond_to(:exists_by_match_id?)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(4).and_return(false)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(3).and_return(true)
        expect(RankingItemQueries).to respond_to(:all_by_match_id)
        allow(RankingItemQueries).to receive(:all_by_match_id).with(3).ordered.and_return(expected_ranking_items)

        actual_ranking_set = subject.find_previous(5)
        expect(actual_ranking_set).to be_an_instance_of RankingSet
        expect(actual_ranking_set.match_id).to be 3
        expect(actual_ranking_set.send(:ranking_items)).to eq expected_ranking_items
      end
    end

    context 'when there are no previous RankingItems for current_match_id' do

      it 'should return RankingItemSet with match_id 0 and no RankingItems' do
        expect(RankingItemQueries).to respond_to(:exists_by_match_id?)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(2).and_return(false)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(1).and_return(false)

        actual_ranking_set = subject.find_previous(3)
        expect(actual_ranking_set).to be_an_instance_of RankingSet
        expect(actual_ranking_set).to be_neutral
      end
    end

    context 'when current_match_id belongs to first match' do

      it 'should return RankingItemSet with match_id 0 and no RankingItems' do
        actual_ranking_set = subject.find_previous(1)
        expect(actual_ranking_set).to be_an_instance_of RankingSet
        expect(actual_ranking_set).to be_neutral
      end
    end
  end

  describe '#find_next_match_id' do

    context 'when there are next RankingItems for match id' do

      it 'should return created RankingItemSet' do
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(5).and_return(false)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(6).and_return(true)

        expect(subject.find_next_match_id(4)).to eq 6
      end
    end

    context 'when there are no next RankingItems for match id' do

      it 'should return nil' do
        allow(RankingItem).to receive(:exists_by_match_id?).with(6).and_return(false)
        allow(RankingItem).to receive(:exists_by_match_id?).with(7).and_return(false)

        expect(subject.find_next_match_id(5)).to be_nil
      end
    end

    context 'when current_match_id belongs to last macht' do

      it 'should return nil' do
        allow(RankingItem).to receive(:exists_by_match_id?).never
        expect(subject.find_next_match_id(7)).to be_nil
      end
    end
  end

end