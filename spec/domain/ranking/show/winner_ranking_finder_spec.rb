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
    expect(RankingItem).
        to receive(:ranking_set_for_listing_by_positions).with(positions: [1, 2, 3]).
        and_return(winner_ranking_items)
  end

  describe '#find_first_places' do

    context 'when winner RankingItems are present' do

      it 'should return all ChampionTip-RankingItems with position 1' do
        actual_ranking_items = subject.find_first_places
        expect(actual_ranking_items.count).to eq 1
        expect(actual_ranking_items).to include winner_ranking_items.first
      end
    end

    context 'when no winner RankingItems are present' do

      let(:winner_ranking_items) { [] }

      it 'should return empty Array' do
        expect(subject.find_first_places).to eq([])
      end
    end
  end

  describe '#find_second_places' do

    context 'when winner RankingItems are present' do

      it 'should return all ChampionTip-RankingItems with position 2' do
        actual_ranking_items = subject.find_second_places
        expect(actual_ranking_items.count).to eq 2
        expect(actual_ranking_items).to include winner_ranking_items.second, winner_ranking_items.fourth
      end
    end

    context 'when no winner RankingItems are present' do

      let(:winner_ranking_items) { [] }

      it 'should return empty Array' do
        expect(subject.find_second_places).to eq([])
      end
    end
  end

  describe '#find_third_places' do

    context 'when winner RankingItems are present' do

      it 'should return all ChampionTip-RankingItems with position 2' do
        actual_ranking_items = subject.find_third_places
        expect(actual_ranking_items.count).to eq 1
        expect(actual_ranking_items).to include winner_ranking_items.third
      end
    end

    context 'when no winner RankingItems are present' do

      let(:winner_ranking_items) { [] }

      it 'should return empty Array' do
        expect(subject.find_third_places).to eq([])
      end
    end
  end
end