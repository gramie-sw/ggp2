describe RankingService do

  let(:users) do
    [
        create(:player),
        create(:player)
    ]
  end

  let(:matches) do
    [
        create(:match, position: 1),
        create(:match, position: 2),
        create(:match, position: 3),
        create(:match, position: 4)
    ]
  end

  let(:tips) do
    [
        create(:tip, user: users[0], match: matches[1]),
        create(:tip, user: users[1], match: matches[1])
    ]
  end

  let(:predecessor_ranking_items) do
    [
        create(:ranking_item, match: matches[0], user: users[0]),
        create(:ranking_item, match: matches[0], user: users[1])
    ]
  end

  let(:ranking_items) do
    [
        create(:ranking_item, match: matches[1], user: users[0]),
        create(:ranking_item, match: matches[1], user: users[1])
    ]
  end

  let(:successor_ranking_items) do
    [
        create(:ranking_item, match: matches[3], user: users[0]),
        create(:ranking_item, match: matches[3], user: users[1])
    ]
  end


  subject { RankingService.new match: matches[1] }


  #describe '#update_all' do
  #
  #  before(:each) do
  #    users
  #    matches
  #    tips
  #    predecessor_ranking_items
  #    ranking_items
  #    successor_ranking_items
  #  end
  #
  #  subject { RankingService.new match: matches[1] }
  #
  #  it 'should update all' do
  #    #subject.instance_variable_get(:@ranking_item_set).should_receive(:destroy_ranking_items).and_call_original
  #    #subject.instance_variable_get(:@ranking_item_set).should_receive(:create_ranking_items).and_call_original
  #    #RankingItemsPositionSetter.should_receive(:set_positions).with(subject.instance_variable_get(:@ranking_item_set).create_ranking_items).and_call_original
  #    subject.update_all
  #  end
  #end

  describe '#ranking_item_set' do

    it 'should return new RankingItemSet with match from RankingService' do
      ranking_item_set = subject.ranking_item_set
      ranking_item_set.should be_an_instance_of RankingItemSet
      ranking_item_set.send(:match).should eq matches[1]
    end

    it 'should cache new RankingItemSet' do
      subject.ranking_item_set.should be subject.ranking_item_set
    end
  end

  #describe '#update_all' do
  #
  #  it 'should update all ranking items over all effected ranking item sets' do
  #    subject.should_receive(:update).with(subject.ranking_item_set)
  #
  #
  #    subject.update_all
  #
  #
  #  end
  #end

  describe '#update' do

    let(:process_ranking_item_set) { double('process_ranking_item_set')}
    let(:build_ranking_items) { double('build_ranking_items')}

    it 'should destroy all ranking items and build and save new ranking items' do
      subject.should_receive(:build).with(process_ranking_item_set).and_return(build_ranking_items)
      process_ranking_item_set.should_receive(:destroy_existing_and_save_built_ranking_items).with(build_ranking_items)

      subject.update process_ranking_item_set
    end
  end


  describe '#build' do
    let(:process_ranking_item_set) { double('process_ranking_item_set')}
    let(:build_ranking_items) { double('build_ranking_items')}

    it 'should return build ranking items for given ranking_item set' do

      process_ranking_item_set.should_receive(:build_ranking_items).and_return(build_ranking_items)
      RankingItemsPositionSetter.should_receive(:set_positions).with(build_ranking_items)

      subject.build process_ranking_item_set
    end
  end
end