describe RankingItemSetCreator do

  let(:match) { build(:match, id: 12) }
  let(:match_ids) { [10, 11, match.id, 14, 15] }

  subject { RankingItemSetCreator.new match: match, match_ids: match_ids }

  describe '#next_ranking_item_set' do

    context 'if there is a next match with a ranking item set' do
      it 'should return ranking item set for the next match id' do
        next_ranking_item = create(:ranking_item, match_id: 15)
        next_ranking_items = subject.next_ranking_item_set
        next_ranking_items.should include next_ranking_item
        next_ranking_items.size.should eq 1
      end
    end

    context 'if no following match has a ranking set' do
      it 'should return empty array' do
        subject.next_ranking_item_set.should eq []
      end

    end
  end

  describe '#previous_ranking_item_set' do
    context 'if there is a previous match with a ranking item set' do
      it 'should return ranking item set for previous match id' do
        previous_ranking_item = create(:ranking_item, match_id: 10)
        previous_ranking_items = subject.previous_ranking_item_set
        previous_ranking_items.should include previous_ranking_item
        previous_ranking_items.size.should eq 1
      end
    end

    context 'if there is no previous match with a ranking item set ' do
      it 'should return empty array' do
        subject.previous_ranking_item_set.should eq []
      end
    end
  end

  describe '#create' do

    let(:user_1) { build(:player)}
    let(:user_2) { build(:player)}

    let(:previous_ranking_item_1) { build(:ranking_item, user: user_1)}
    let(:previous_ranking_item_2) { build(:ranking_item)}

    let(:tip_1) { build(:tip, user: user_1)}
    let(:tip_2) { build(:tip, user: user_2)}

    it 'should return ranking item set for match' do

      subject.should_receive(:previous_ranking_item_set).and_return([previous_ranking_item_1, previous_ranking_item_2])
      Tip.should_receive(:find).with(match_id: match.id).and_return([tip_1, tip_2])

      user_1.stub(:id).and_return(12)
      user_2.stub(:id).and_return(13)

      RankingItemFactory.should_receive(:build_ranking_item).with(previous_ranking_item_1, tip_1).and_call_original
      RankingItemFactory.should_receive(:build_ranking_item).with(tip_2).and_call_original

      ranking_items = subject.create
      ranking_items.size.should eq 2
      ranking_items.each { |ranking_item| ranking_item.should be_an_instance_of RankingItem}
    end
  end

  describe '#destroy' do
    it 'should destroy all ranking items for current ranking item set' do
      RankingItem.should_receive(:destroy_all).with(match)
      subject.destroy
    end
  end
end