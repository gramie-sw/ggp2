describe RankingService do

  let(:match) { build(:match) }
  subject { RankingService.new match: match }

  describe '#ranking_item_set' do

    it 'should return new RankingItemSet with match from RankingService' do
      ranking_item_set = subject.ranking_item_set
      ranking_item_set.should be_an_instance_of RankingItemSet
      ranking_item_set.send(:match).should eq match
    end

    it 'should cache new RankingItemSet' do
      subject.ranking_item_set.should be subject.ranking_item_set
    end
  end

  describe '#update_all' do

    let(:successor_ranking_item_set) { double 'successor_ranking_item_set' }

    it 'should update all ranking items over all effected ranking item sets' do
      subject.should_receive(:update).with(subject.ranking_item_set)
      subject.ranking_item_set.should_receive(:successor_ranking_item_set).and_return(successor_ranking_item_set)
      subject.should_receive(:update).with(successor_ranking_item_set)
      successor_ranking_item_set.should_receive(:successor_ranking_item_set).and_return nil
      subject.update_all
    end
  end

  describe '#update' do

    let(:process_ranking_item_set) { double('process_ranking_item_set') }
    let(:build_ranking_items) { double('build_ranking_items') }

    it 'should destroy all ranking items and build and save new ranking items' do
      subject.should_receive(:build).with(process_ranking_item_set).and_return(build_ranking_items)
      process_ranking_item_set.should_receive(:update).with(build_ranking_items)

      subject.update process_ranking_item_set
    end
  end

  describe '#build' do
    let(:process_ranking_item_set) { double('process_ranking_item_set') }
    let(:build_ranking_items) { double('build_ranking_items') }

    it 'should return build ranking items for given ranking_item set' do

      process_ranking_item_set.should_receive(:build_ranking_items).and_return(build_ranking_items)
      RankingItemsPositionSetter.should_receive(:set_positions).with(build_ranking_items)

      subject.build process_ranking_item_set
    end
  end
end