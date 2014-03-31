describe RankingItemSetService do

  let(:ranking_item_repository) { RankingItem }
  subject { RankingItemSetService.new ranking_item_repository: ranking_item_repository }

  describe '#previous_ranking_item_set' do

    let(:ordered_match_ids) { [1, 2, 3, 4, 5, 6, 7] }

    context 'when there are previous RankingItems for match id' do

      it 'should return created RankingItemSet by reversing ordered match_ids' do
        expected_ranking_items = [RankingItem.new(match_id: 3)]

        ranking_item_repository.stub(:ranking_items_by_match_id).with(4).ordered.and_return([])
        ranking_item_repository.stub(:ranking_items_by_match_id).with(3).ordered.and_return(expected_ranking_items)

        actual_ranking_item_set = subject.previous_ranking_item_set(5, ordered_match_ids)
        actual_ranking_item_set.should be_an_instance_of RankingItemSet
        actual_ranking_item_set.match_id.should be 3
        actual_ranking_item_set.send(:ranking_items).should eq expected_ranking_items
      end
    end

    context 'when there are no previous RankingItems for match id' do

      it 'should return nil' do
        ranking_item_repository.stub(:ranking_items_by_match_id).with(2).ordered.and_return([])
        ranking_item_repository.stub(:ranking_items_by_match_id).with(1).ordered.and_return([])

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

    context 'when there are next RankingItems for match id' do

      let(:ranking_items) { [RankingItem.new(match_id: 12)] }

      it 'should return created RankingItemSet' do
        ranking_item_repository.stub(:ranking_items_by_match_id).with(11).and_return([])
        ranking_item_repository.stub(:ranking_items_by_match_id).with(12).and_return(ranking_items)

        actual_ranking_item_set = subject.next_ranking_item_set [11, 12]
        actual_ranking_item_set.should be_an_instance_of RankingItemSet
        actual_ranking_item_set.match_id.should be 12
        actual_ranking_item_set.send(:ranking_items).should eq ranking_items
      end
    end

    context 'when there are no next ranking items for match id' do

      it 'should return nil' do
        ranking_item_repository.stub(:ranking_items_by_match_id).with(12).and_return([])
        subject.next_ranking_item_set([12]).should be_nil
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