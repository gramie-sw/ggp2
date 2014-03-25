describe RankingItemSetService do

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

  let(:previous_ranking_items) do
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

  let(:following_ranking_items) do
    [
        create(:ranking_item, match: matches[3], user: users[0]),
        create(:ranking_item, match: matches[3], user: users[1])
    ]
  end


  describe '#update_ranking_items' do

    before(:each) do
      users
      matches
      tips
      previous_ranking_items
      ranking_items
      following_ranking_items
    end

    subject { RankingItemSetService.new match: matches[1] }

    it 'should update ranking items' do

      subject.instance_variable_get(:@ranking_item_set).should_receive(:destroy_ranking_items).and_call_original
      subject.instance_variable_get(:@ranking_item_set).should_receive(:create_ranking_items).and_call_original
      #RankingItemsPositionSetter.should_receive(:set_positions).and_call_original
      subject.update_ranking_items
    end
  end
end