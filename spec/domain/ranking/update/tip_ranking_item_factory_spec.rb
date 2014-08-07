describe TipRankingItemFactory do

  let(:previous_ranking_item) do
    correct_tips_count = 3
    correct_tendency_tips_only_count = 5
    points =
        correct_tips_count * Ggp2.config.correct_tip_points +
            correct_tendency_tips_only_count * Ggp2.config.correct_tendency_tip_only_points

    RankingItem.new(
        points: points,
        correct_tips_count: correct_tips_count,
        correct_tendency_tips_only_count: correct_tendency_tips_only_count)
  end

  let(:tip) { Tip.new match_id: 10, user_id: 11 }

  describe '::build_ranking_item' do

    it 'should return new RankingItem with user_id of given tip' do
      actual_ranking_item = subject.build(tip, previous_ranking_item)
      expect(actual_ranking_item.user_id).to eq tip.user_id
    end

    it 'should return new RankingItem with match_id of given tip' do
      actual_ranking_item = subject.build(tip, previous_ranking_item)
      expect(actual_ranking_item.match_id).to eq tip.match_id
    end

    context 'when tip was wrong' do

      it 'should return RankingItem with same values as previous one' do
        allow(tip).to receive(:result).and_return(Tip::RESULTS[:incorrect])

        actual_ranking_item = subject.build(tip, previous_ranking_item)
        expect(actual_ranking_item.points).to eq previous_ranking_item.points
        expect(actual_ranking_item.correct_tips_count).to eq previous_ranking_item.correct_tips_count
        expect(actual_ranking_item.correct_tendency_tips_only_count).to eq previous_ranking_item.correct_tendency_tips_only_count
        expect(actual_ranking_item.correct_champion_tip).to eq previous_ranking_item.correct_champion_tip
      end
    end

    context 'when tip is correct' do

      it 'should return RankingItem with new correct tip and points values' do
        allow(tip).to receive(:result).and_return(Tip::RESULTS[:correct])

        actual_ranking_item = subject.build(tip, previous_ranking_item)
        expect(actual_ranking_item.points).to eq previous_ranking_item.points + Ggp2.config.correct_tip_points
        expect(actual_ranking_item.correct_tips_count).to eq previous_ranking_item.correct_tips_count + 1
        expect(actual_ranking_item.correct_tendency_tips_only_count).to eq previous_ranking_item.correct_tendency_tips_only_count
        expect(actual_ranking_item.correct_champion_tip).to eq previous_ranking_item.correct_champion_tip
      end
    end

    context 'when tip has only correct tendency' do

      it 'should return ranking item with new correct tendency tip count and points values' do
        allow(tip).to receive(:result).and_return(Tip::RESULTS[:correct_tendency_only])

        actual_ranking_item = subject.build(tip, previous_ranking_item)
        expect(actual_ranking_item.points).to eq previous_ranking_item.points + Ggp2.config.correct_tendency_tip_only_points
        expect(actual_ranking_item.correct_tips_count).to eq previous_ranking_item.correct_tips_count
        expect(actual_ranking_item.correct_tendency_tips_only_count).to eq previous_ranking_item.correct_tendency_tips_only_count + 1
        expect(actual_ranking_item.correct_champion_tip).to eq previous_ranking_item.correct_champion_tip
      end
    end
  end
end
