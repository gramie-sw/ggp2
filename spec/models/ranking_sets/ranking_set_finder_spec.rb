describe RankingSetFinder do

  let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }

  before :each do
    expect(MatchQueries).to respond_to(:all_match_ids_ordered_by_position)
    expect(MatchQueries).to receive(:all_match_ids_ordered_by_position).and_return(ordered_match_ids)
    expect(RankingItemQueries).to respond_to(:exists_by_match_id?)
  end

  describe '#find_previous' do

    context 'when there are previous RankingItems for given match_id' do

      it 'returns created RankingSet' do
        expected_ranking_items = [RankingItem.new(match_id: 3)]

        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(4).and_return(false)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(3).and_return(true)
        expect(RankingItemQueries).to respond_to(:all_by_match_id)
        allow(RankingItemQueries).to receive(:all_by_match_id).with(3).and_return(expected_ranking_items)

        actual_ranking_set = subject.find_previous(5)
        expect(actual_ranking_set).to be_an_instance_of RankingSet
        expect(actual_ranking_set.match_id).to be 3
        expect(actual_ranking_set.send(:ranking_items)).to eq expected_ranking_items
      end
    end

    context 'when there are no previous RankingItems for match_id' do

      it 'returns neutral RankingSet' do
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(2).and_return(false)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(1).and_return(false)

        actual_ranking_set = subject.find_previous(3)
        expect(actual_ranking_set).to be_an_instance_of RankingSet
        expect(actual_ranking_set).to be_neutral
      end
    end

    context 'when match_id belongs to first match' do

      it 'returns neutral RankingSet' do
        actual_ranking_set = subject.find_previous(1)
        expect(actual_ranking_set).to be_an_instance_of RankingSet
        expect(actual_ranking_set).to be_neutral
      end
    end

    context 'when given match_id is nil' do

      it 'returns the last existing Tip-RankingSet if it exists' do
        expected_ranking_items = [RankingItem.new(match_id: 7)]
        allow(RankingItemQueries).to receive(:exists_by_match_id?).and_return(false)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(7).and_return(true)
        expect(RankingItemQueries).to respond_to(:all_by_match_id)
        allow(RankingItemQueries).to receive(:all_by_match_id).with(7).and_return(expected_ranking_items)

        actual_ranking_set = subject.find_previous(nil)
        expect(actual_ranking_set).to be_an_instance_of RankingSet
        expect(actual_ranking_set.match_id).to be 7
        expect(actual_ranking_set.send(:ranking_items)).to eq expected_ranking_items
      end

      it 'returns a neutral RankingSet if no Tip-RankingSet exits' do
        allow(RankingItemQueries).to receive(:exists_by_match_id?).and_return(false)

        actual_ranking_set = subject.find_previous(nil)
        expect(actual_ranking_set).to be_an_instance_of RankingSet
        expect(actual_ranking_set).to be_neutral
      end
    end
  end

  describe '#find_next_match_id' do

    context 'when there is an existing RankingSet for given match_id' do

      it 'returns next match_id with existing RankingSet' do
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(5).and_return(false)
        allow(RankingItemQueries).to receive(:exists_by_match_id?).with(6).and_return(true)

        expect(subject.find_next_match_id(4)).to eq 6
      end
    end

    context 'when there is no existing next RankingSet for given match_id' do

      it 'returns 0' do
        expect(RankingItemQueries).to receive(:exists_by_match_id?).with(6).and_return(false)
        expect(RankingItemQueries).to receive(:exists_by_match_id?).with(7).and_return(false)
        expect(RankingItemQueries).to receive(:exists_by_match_id?).with(nil).and_return(false)

        expect(subject.find_next_match_id(5)).to be 0
      end
    end

    context 'when there is only the ChampionTip-RankingSet existing as next for given match_id' do

      it 'returns nil' do
        expect(RankingItemQueries).to receive(:exists_by_match_id?).with(6).and_return(false)
        expect(RankingItemQueries).to receive(:exists_by_match_id?).with(7).and_return(false)
        expect(RankingItemQueries).to receive(:exists_by_match_id?).with(nil).and_return(true)
        expect(subject.find_next_match_id(5)).to be_nil
      end
    end

    context 'when nil is given as match_id' do

      it 'returns 0' do
        expect(subject.find_next_match_id(nil)).to be 0
      end
    end
  end
end