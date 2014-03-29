describe RankingItemSet do

  let(:build_match) { build(:match, id: 12) }
  let(:ordered_match_ids) { [10, 11, build_match.id, 14, 15] }

  subject { RankingItemSet.new match: build_match, ordered_match_ids: ordered_match_ids }

  describe '#successor_ranking_item_set' do

    context 'if there is a successor match with ranking items' do

      let(:ranking_item) {build(:ranking_item, user_id: 15)}
      let(:match_with_id_15) { double('match with id 15')}


      it 'should return new successor RankingItemSet' do
        subject.should_receive(:create_following_ranking_item_set).with([14,15]).and_call_original
        subject.should_receive(:following_match_id_which_has_ranking_items).with([14,15]).and_call_original
        RankingItem.should_receive(:where).with(match_id: 14).and_call_original
        RankingItem.should_receive(:where).with(match_id: 15).and_return(ranking_item)
        Match.should_receive(:find).with(15).and_return(match_with_id_15)

        successor_ranking_item_set = subject.successor_ranking_item_set
        successor_ranking_item_set.should be_an_instance_of RankingItemSet
        successor_ranking_item_set.send(:match).should eq match_with_id_15
        successor_ranking_item_set.send(:ordered_match_ids).should eq ordered_match_ids
      end
    end

    context 'if there is no successor match with ranking items' do
      it 'should return nil' do
        subject.should_receive(:create_following_ranking_item_set).with([14,15]).and_call_original
        subject.should_receive(:following_match_id_which_has_ranking_items).with([14,15]).and_call_original
        subject.successor_ranking_item_set.should be_nil
      end
    end
  end

  describe '#predecessor_ranking_item_set' do

    let(:ranking_item) {build(:ranking_item, user_id: 10)}
    let(:match_with_id_10) { double('match with id 10')}

    context 'if there is a predecessor match with ranking items' do
      it 'should return new predecessor RankingItemSet' do
        subject.should_receive(:create_following_ranking_item_set).with([11,10]).and_call_original
        subject.should_receive(:following_match_id_which_has_ranking_items).with([11,10]).and_call_original
        RankingItem.should_receive(:where).with(match_id: 11).and_call_original
        RankingItem.should_receive(:where).with(match_id: 10).and_return(ranking_item)
        Match.should_receive(:find).with(10).and_return(match_with_id_10)

        predecessor_ranking_item_set = subject.predecessor_ranking_item_set
        predecessor_ranking_item_set.should be_an_instance_of RankingItemSet
        predecessor_ranking_item_set.send(:match).should eq match_with_id_10
        predecessor_ranking_item_set.send(:ordered_match_ids).should eq ordered_match_ids
      end
    end

    context 'if there is no predecessor match with ranking items' do
      it 'should return nil' do
        subject.should_receive(:create_following_ranking_item_set).with([11,10]).and_call_original
        subject.should_receive(:following_match_id_which_has_ranking_items).with([11,10]).and_call_original
        subject.predecessor_ranking_item_set.should be_nil
      end
    end
  end

  describe '#ranking_items' do

    let(:ranking_items) { double(['ranking_items'])}

    context 'if no match id is given' do
      it 'should return ranking items for current ranking item set' do
        RankingItem.should_receive(:where).with(match_id: build_match.id).and_return ranking_items
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

  describe '#build_ranking_items' do

    let(:user_1) { build(:player)}
    let(:user_2) { build(:player)}

    let(:predecessor_ranking_item_1) { build(:ranking_item, user: user_1)}
    let(:predecessor_ranking_item_2) { build(:ranking_item)}

    let(:tip_1) { build(:tip, user: user_1)}
    let(:tip_2) { build(:tip, user: user_2)}

    it 'should return built ranking items for match' do
      subject.should_receive(:predecessor_ranking_items).and_return([predecessor_ranking_item_1, predecessor_ranking_item_2])
      Tip.should_receive(:where).with(match_id: build_match.id).and_return([tip_1, tip_2])

      user_1.stub(:id).and_return(12)
      user_2.stub(:id).and_return(13)

      RankingItemFactory.should_receive(:build_ranking_item).with(predecessor_ranking_item_1, tip_1).and_call_original
      RankingItemFactory.should_receive(:build_ranking_item).with(tip_2).and_call_original

      ranking_items = subject.build_ranking_items
      ranking_items.size.should eq 2
      ranking_items.each { |ranking_item| ranking_item.should be_an_instance_of RankingItem}
    end
  end

  describe '#update' do

    let(:build_ranking_items) do
      [
        build(:ranking_item),
        build(:ranking_item)
      ]
    end

    it 'should update' do
      RankingItem.should_receive(:transaction).and_yield
      RankingItem.should_receive(:destroy_all).with(match: build_match).ordered
      build_ranking_items[0].should_receive(:save!).ordered
      build_ranking_items[1].should_receive(:save!).ordered

      subject.update(build_ranking_items).should be_true
    end

    it 'should update transactional' do
      build_ranking_items[1].should_receive(:save!).and_raise(ActiveRecord::Rollback)
      subject.update(build_ranking_items).should be_false
      RankingItem.all.size.should be 0
    end
  end
end