describe TipRankingSetFinder do

  let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }

  before :each do
    expect(MatchQueries).to respond_to(:all_match_ids_ordered_by_position)
    expect(MatchQueries).to receive(:all_match_ids_ordered_by_position).and_return(ordered_match_ids)
    expect(RankingItemQueries).to respond_to(:exists_by_match_id?)
  end

  describe '#find_previous' do

    it 'returns created RankingSet when there are previous RankingItems for given match_id' do
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

    it 'returns neutral RankingSet when there are no previous RankingItems for given match_id' do
      expect(RankingItemQueries).to respond_to(:exists_by_match_id?)
      allow(RankingItemQueries).to receive(:exists_by_match_id?).with(2).and_return(false)
      allow(RankingItemQueries).to receive(:exists_by_match_id?).with(1).and_return(false)

      actual_ranking_set = subject.find_previous(3)
      expect(actual_ranking_set).to be_an_instance_of RankingSet
      expect(actual_ranking_set).to be_neutral
    end

    it 'returns neutral RankingSet when current_match_id belongs to first match' do
      actual_ranking_set = subject.find_previous(1)
      expect(actual_ranking_set).to be_an_instance_of RankingSet
      expect(actual_ranking_set).to be_neutral
    end
  end

  describe '#find_next_match_id' do

    it 'returns next match_id with existing RankingSet when there are next RankingSets for given match_id' do
      allow(RankingItemQueries).to receive(:exists_by_match_id?).with(5).and_return(false)
      allow(RankingItemQueries).to receive(:exists_by_match_id?).with(6).and_return(true)

      expect(subject.find_next_match_id(4)).to eq 6
    end

    it 'returns nil when there are no next RankingSets for given match_id' do
      expect(RankingItemQueries).to receive(:exists_by_match_id?).with(6).and_return(false)
      expect(RankingItemQueries).to receive(:exists_by_match_id?).with(7).and_return(false)

      expect(subject.find_next_match_id(5)).to be_nil
    end

    it 'returns nil when given match_id belongs to last Match' do
      allow(RankingItemQueries).to receive(:exists_by_match_id?).never
      expect(subject.find_next_match_id(7)).to be_nil
    end
  end

  describe '#find_previous_match_id' do

    it 'returns previous match_id if previous RankingSets exists for given macht_id' do
      allow(RankingItemQueries).to receive(:exists_by_match_id?).with(2).and_return(true)
      allow(RankingItemQueries).to receive(:exists_by_match_id?).with(3).and_return(false)

      expect(subject.find_previous_match_id(4)).to be 2
    end

    it 'returns nil when there are no previous RankingSets for given match_id' do
      allow(RankingItemQueries).to receive(:exists_by_match_id?).with(1).and_return(false)
      allow(RankingItemQueries).to receive(:exists_by_match_id?).with(2).and_return(false)

      expect(subject.find_previous_match_id(3)).to be_nil
    end

    it 'returns nil when given match_id belongs to first Match' do
      expect(subject.find_next_match_id(1)).to be_nil
    end
  end

  describe '#exists_next?' do

    it 'returns true if a next RankingSet exists for given match_id ' do
      expect(RankingItemQueries).to receive(:exists_by_match_id?).with(6).and_return(false)
      expect(RankingItemQueries).to receive(:exists_by_match_id?).with(7).and_return(true)
      expect(subject.exists_next?(5)).to be true
    end

    it 'returns false if no next RankingSet exists for given match_id ' do
      allow(RankingItemQueries).to receive(:exists_by_match_id?).and_return(false)
      expect(subject.exists_next?(4)).to be false
    end
  end

  describe '#exists_for_last_match?' do

    it 'returns true if RankingSets for last Match exist' do
      expect(RankingItemQueries).to receive(:exists_by_match_id?).with(7).and_return(true)
      expect(subject.exists_for_last_match?).to be true
    end

    it 'returns false if no RankingItem for last Match exist' do
      expect(RankingItemQueries).to receive(:exists_by_match_id?).with(7).and_return(false)
      expect(subject.exists_for_last_match?).to be false
    end
  end
end