describe RankingItemSet do

  let(:match) { build(:match, id: 12) }
  let(:match_ids) { [10, 11, match.id, 14, 15] }

  subject { RankingItemSet.new match: match, match_ids: match_ids }

  describe '#next_rankings' do

    context 'if there is a next match with a ranking items' do
      it 'should return ranking items for the next match id' do
        next_ranking_item = create(:ranking_item, match_id: 15)
        next_ranking_items = subject.next_ranking_items
        next_ranking_items.should include next_ranking_item
        next_ranking_items.size.should eq 1
      end
    end

    context 'if no following match has ranking items' do
      it 'should return empty array' do
        subject.next_ranking_items.should eq []
      end
    end
  end

  describe '#previous_ranking_items' do
    context 'if there is a previous match with ranking items' do
      it 'should return ranking items for previous match id' do
        previous_ranking_item = create(:ranking_item, match_id: 10)
        previous_ranking_items = subject.previous_ranking_items
        previous_ranking_items.should include previous_ranking_item
        previous_ranking_items.size.should eq 1
      end
    end

    context 'if there is no previous match with ranking items' do
      it 'should return empty array' do
        subject.previous_ranking_items.should eq []
      end
    end
  end

  describe '#ranking_items' do

    let(:ranking_items) { double(['ranking_items'])}

    context 'if no match id is given' do
      it 'should return ranking items for current ranking item set' do
        RankingItem.should_receive(:where).with(match_id: match.id).and_return ranking_items
        subject.ranking_items.should eq ranking_items
      end
    end

    context 'if match id is given' do
      it 'should return ranking items for given match id' do
        RankingItem.should_receive(:where).with(match_id: 10).and_return ranking_items
        subject.ranking_items(10).should eq ranking_items
      end
    end
  end

  describe '#create_ranking_items' do

    let(:user_1) { build(:player)}
    let(:user_2) { build(:player)}

    let(:previous_ranking_item_1) { build(:ranking_item, user: user_1)}
    let(:previous_ranking_item_2) { build(:ranking_item)}

    let(:tip_1) { build(:tip, user: user_1)}
    let(:tip_2) { build(:tip, user: user_2)}

    it 'should return created ranking items for match' do
      subject.should_receive(:previous_ranking_items).and_return([previous_ranking_item_1, previous_ranking_item_2])
      Tip.should_receive(:find).with(match_id: match.id).and_return([tip_1, tip_2])

      user_1.stub(:id).and_return(12)
      user_2.stub(:id).and_return(13)

      RankingItemFactory.should_receive(:build_ranking_item).with(previous_ranking_item_1, tip_1).and_call_original
      RankingItemFactory.should_receive(:build_ranking_item).with(tip_2).and_call_original

      ranking_items = subject.create_ranking_items
      ranking_items.size.should eq 2
      ranking_items.each { |ranking_item| ranking_item.should be_an_instance_of RankingItem}
    end
  end

  describe '#destroy' do
    it 'should destroy all ranking items for current ranking item set' do
      RankingItem.should_receive(:destroy_all).with(match)
      subject.destroy_ranking_items
    end
  end
end