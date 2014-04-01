describe RankingItemSetService do

  let(:ranking_item_repository) { RankingItem }
  subject { RankingItemSetService.new ranking_item_repository: ranking_item_repository }

  describe '#previous_ranking_item_set' do

    let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }

    context 'when there are previous RankingItems for match id' do

      it 'should return created RankingItemSet by reversing ordered match_ids' do
        expected_ranking_items = [RankingItem.new(match_id: 3)]

        ranking_item_repository.stub(:exists_by_match_id?).with(4).and_return(false)
        ranking_item_repository.stub(:exists_by_match_id?).with(3).and_return(true)
        ranking_item_repository.stub(:ranking_items_by_match_id).with(3).ordered.and_return(expected_ranking_items)

        actual_ranking_item_set = subject.previous_ranking_item_set(5, ordered_match_ids)
        actual_ranking_item_set.should be_an_instance_of RankingItemSet
        actual_ranking_item_set.match_id.should be 3
        actual_ranking_item_set.send(:ranking_items).should eq expected_ranking_items
      end
    end

    context 'when there are no previous RankingItems for match id' do

      it 'should return nil' do
        ranking_item_repository.stub(:exists_by_match_id?).with(2).and_return(false)
        ranking_item_repository.stub(:exists_by_match_id?).with(1).and_return(false)

        subject.previous_ranking_item_set(3, ordered_match_ids).should be_nil
      end
    end

    context 'when there is no previous match_id of current_match_id' do

      it 'should return nil' do
        ranking_item_repository.stub(:ranking_items_by_match_id).never
        subject.previous_ranking_item_set(1, ordered_match_ids).should be_nil
      end
    end
  end

  describe '#previous_or_neutral_ranking_item_set' do

    let(:current_match_id) { 2 }
    let(:ordered_match_ids) { [1, 2, 3] }

    context 'when #previous_ranking_item_set returns a RinkingItemSet' do


      it 'should return found RankingItemSet' do
        expected_ranking_item_set = RankingItemSet.new(match_id: 1, ranking_items: [])

        subject.should_receive(:previous_ranking_item_set).
            with(current_match_id, ordered_match_ids).and_return(expected_ranking_item_set)
        subject.should_receive(:neutral_ranking_item_set).never

        actual_ranking_item_set = subject.previous_or_neutral_ranking_item_set(current_match_id, ordered_match_ids)
        actual_ranking_item_set.should be expected_ranking_item_set
      end
    end

    context 'when #previous_ranking_item_set returns a nil' do

      it 'should return neutral RankingItemSet' do
        expected_neutral_ranking_item_set = RankingItemSet.new(match_id: 0, ranking_items: [])

        subject.should_receive(:previous_ranking_item_set).
            with(current_match_id, ordered_match_ids).ordered.and_return(nil)
        subject.should_receive(:neutral_ranking_item_set).ordered.and_return(expected_neutral_ranking_item_set)

        actual_ranking_item_set = subject.previous_or_neutral_ranking_item_set(current_match_id, ordered_match_ids)
        actual_ranking_item_set.should be expected_neutral_ranking_item_set
      end
    end
  end

  describe '#next_ranking_item_set_match_id' do

    let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }

    context 'when there are next RankingItems for match id' do

      it 'should return created RankingItemSet' do
        ranking_item_repository.stub(:exists_by_match_id?).with(5).and_return(false)
        ranking_item_repository.stub(:exists_by_match_id?).with(6).and_return(true)

        subject.next_ranking_item_set_match_id(4, ordered_match_ids).should eq 6
      end
    end

    context 'when there are no next RankingItems for match id' do
      it 'should return nil' do
        ranking_item_repository.stub(:exists_by_match_id?).with(6).and_return(false)
        ranking_item_repository.stub(:exists_by_match_id?).with(7).and_return(false)

        subject.next_ranking_item_set_match_id(5, ordered_match_ids).should be_nil
      end
    end

    context 'when there are no next match_id in ordered match_ids' do

      it 'should return nil' do
        ranking_item_repository.stub(:exists_by_match_id?).never
        subject.next_ranking_item_set_match_id(7, ordered_match_ids).should be_nil
      end
    end
  end

  describe '#neutral_ranking_item_set' do

    it 'should return RankingItemSet with match_id 0 and no RankingItems' do
      RankingItemSet.should_receive(:new).with(match_id: 0, ranking_items: []).and_return(:neutral_ranking_item_set)
      subject.neutral_ranking_item_set.should eq :neutral_ranking_item_set
    end
  end

  describe '#save_ranking_item_set' do

    let(:ranking_item_set) { RankingItemSet.new match_id: 12, ranking_items: [12, 13] }

    it 'should save ranking item set' do
      subject.send(:ranking_item_repository).should_receive(:update_multiple).with(12, [12, 13])
      subject.save_ranking_item_set ranking_item_set
    end
  end
end