describe RankingItemSet do

  let(:match) { build(:match, id: 12) }
  let(:match_ids) { [10, 11, match.id, 14, 15] }

  subject { RankingItemSet.new match: match, match_ids: match_ids }

  describe '#next_ranking_item_set' do

    context 'if there is a next match with ranking items' do

      let(:ranking_item) {build(:ranking_item, user_id: 15)}
      let(:match_with_id_15) { double('match with id 15')}

      it 'should return new next RankingItemSet' do
        subject.should_receive(:create_following_ranking_item_set).with([14,15]).and_call_original
        subject.should_receive(:following_match_id_which_has_ranking_items).with([14,15]).and_call_original
        RankingItem.should_receive(:where).with(match_id: 14).and_call_original
        RankingItem.should_receive(:where).with(match_id: 15).and_return(ranking_item)
        Match.should_receive(:find).with(15).and_return(match_with_id_15)

        next_ranking_item_set = subject.next_ranking_item_set
        next_ranking_item_set.should be_an_instance_of RankingItemSet
        next_ranking_item_set.instance_variable_get(:@match).should eq match_with_id_15
        next_ranking_item_set.instance_variable_get(:@match_ids).should eq match_ids
      end
    end

    context 'if there is no next match with ranking items' do
      it 'should return nil' do
        subject.should_receive(:create_following_ranking_item_set).with([14,15]).and_call_original
        subject.should_receive(:following_match_id_which_has_ranking_items).with([14,15]).and_call_original
        subject.next_ranking_item_set.should be_nil
      end
    end
  end

  describe '#previous_ranking_item_set' do

    let(:ranking_item) {build(:ranking_item, user_id: 10)}
    let(:match_with_id_10) { double('match with id 10')}

    context 'if there is a previous match with ranking items' do
      it 'should return new previous RankingItemSet' do
        subject.should_receive(:create_following_ranking_item_set).with([11,10]).and_call_original
        subject.should_receive(:following_match_id_which_has_ranking_items).with([11,10]).and_call_original
        RankingItem.should_receive(:where).with(match_id: 11).and_call_original
        RankingItem.should_receive(:where).with(match_id: 10).and_return(ranking_item)
        Match.should_receive(:find).with(10).and_return(match_with_id_10)

        next_ranking_item_set = subject.previous_ranking_item_set
        next_ranking_item_set.should be_an_instance_of RankingItemSet
        next_ranking_item_set.instance_variable_get(:@match).should eq match_with_id_10
        next_ranking_item_set.instance_variable_get(:@match_ids).should eq match_ids
      end
    end

    context 'if there is no previous match with ranking items' do
      it 'should return nil' do
        subject.should_receive(:create_following_ranking_item_set).with([11,10]).and_call_original
        subject.should_receive(:following_match_id_which_has_ranking_items).with([11,10]).and_call_original
        subject.previous_ranking_item_set.should be_nil
      end
    end
  end

  describe '#next_ranking items' do

    context 'if there is a next match with a ranking items' do

      let(:next_ranking_item) { build(:ranking_item, match_id: 15)}

      it 'should return ranking items for the next match id' do
        subject.should_receive(:find_following_ranking_items).with([14, 15]).and_call_original
        RankingItem.should_receive(:where).with(match_id: 14).and_call_original
        RankingItem.should_receive(:where).with(match_id: 15).and_return([next_ranking_item])

        next_ranking_items = subject.next_ranking_items
        next_ranking_items.should include next_ranking_item
        next_ranking_items.size.should eq 1
      end
    end

    context 'if no following match has ranking items' do
      it 'should return nil' do
        subject.next_ranking_items.should be_nil
      end
    end
  end

  describe '#previous_ranking_items' do
    context 'if there is a previous match with ranking items' do

      let(:next_ranking_item) { build(:ranking_item, match_id: 10)}

      it 'should return ranking items for previous match id' do
        subject.should_receive(:find_following_ranking_items).with([11, 10]).and_call_original
        RankingItem.should_receive(:where).with(match_id: 11).and_call_original
        RankingItem.should_receive(:where).with(match_id: 10).and_return([next_ranking_item])

        next_ranking_items = subject.previous_ranking_items
        next_ranking_items.should include next_ranking_item
        next_ranking_items.size.should eq 1
      end
    end

    context 'if there is no previous match with ranking items' do
      it 'should return nil' do
        subject.previous_ranking_items.should be_nil
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