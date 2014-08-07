describe RankingSet do

  let(:ranking_items) do
    [
        RankingItem.new(user_id: 6),
        RankingItem.new(user_id: 8),
        RankingItem.new(user_id: 12),
    ]
  end

  subject { RankingSet.new(match_id: 7, ranking_items: ranking_items) }

  it 'should respond to match_id' do
    expect(subject).to respond_to :match_id
  end

  describe '#ranking_item_of_user' do

    context 'when RankingItem of given user_id exists' do

      it 'should return RankingItem' do
        expect(subject.ranking_item_of_user(8)).to be ranking_items.second
      end
    end

    context 'when RankingItem of given user_id does not exist' do

      it 'should return neutral RankingItem' do
        expect(subject.ranking_item_of_user(13)).to eq RankingItem.neutral
      end
    end

    context 'when RankingSet is neutral' do

      subject { RankingSet.new(match_id: 0, ranking_items: []) }

      it 'should return neutral RankingItem for any user_id' do
        expect(subject.ranking_item_of_user(13)).to eq RankingItem.neutral
      end
    end
  end

  describe '#neutral?' do

    context 'when match_id equals 0 and there are no RankingItems' do

      subject { RankingSet.new(match_id: 0, ranking_items: []) }

      it 'should return true' do
        expect(subject).to be_neutral
      end
    end

    context 'when match_id does not equals 0' do

      subject { RankingSet.new(match_id: 7, ranking_items: []) }

      it 'should return true' do
        expect(subject).not_to be_neutral
      end
    end

    context 'when there are RankingItems' do

      subject { RankingSet.new(match_id: 0, ranking_items: [RankingItem.new]) }

      it 'should return true' do
        expect(subject).not_to be_neutral
      end
    end
  end

  describe '#save' do

    it 'should update RankingItems with repo' do
      expect(RankingItem).to receive(:destroy_and_create_multiple).with(7, ranking_items).and_return(true)
      expect(subject.save).to be_truthy
    end
  end
end