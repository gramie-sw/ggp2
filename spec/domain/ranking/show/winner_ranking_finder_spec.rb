describe WinnerRankingFinder do

  let(:winner_ranking_items) do
    [
        RankingItem.new(position: 1),
        RankingItem.new(position: 2),
        RankingItem.new(position: 3),
        RankingItem.new(position: 2)
    ]
  end

  before :each do
    RankingItem.
        should_receive(:ranking_set_for_listing_by_positions).with(positions: [1, 2, 3]).
        and_return(winner_ranking_items)
  end

  describe '#find_first_places' do

    context 'when winner RankingItems are present' do

      it 'should return all ChampionTip-RankingItems with position 1' do
        actual_ranking_items = subject.find_first_places
        actual_ranking_items.count.should eq 1
        actual_ranking_items.should include winner_ranking_items.first
      end
    end

    context 'when no winner RankingItems are present' do

      let(:winner_ranking_items) { [] }

      it 'should return empty Array' do
        subject.find_first_places.should eq([])
      end
    end
  end

  describe '#find_second_places' do

    context 'when winner RankingItems are present' do

      it 'should return all ChampionTip-RankingItems with position 2' do
        actual_ranking_items = subject.find_second_places
        actual_ranking_items.count.should eq 2
        actual_ranking_items.should include winner_ranking_items.second, winner_ranking_items.fourth
      end
    end

    context 'when no winner RankingItems are present' do

      let(:winner_ranking_items) { [] }

      it 'should return empty Array' do
        subject.find_second_places.should eq([])
      end
    end
  end

  describe '#find_third_places' do

    context 'when winner RankingItems are present' do

      it 'should return all ChampionTip-RankingItems with position 2' do
        actual_ranking_items = subject.find_third_places
        actual_ranking_items.count.should eq 1
        actual_ranking_items.should include winner_ranking_items.third
      end
    end

    context 'when no winner RankingItems are present' do

      let(:winner_ranking_items) { [] }

      it 'should return empty Array' do
        subject.find_third_places.should eq([])
      end
    end
  end
end