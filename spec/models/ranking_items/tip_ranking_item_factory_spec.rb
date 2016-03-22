describe TipRankingItemFactory do

  let(:previous_ranking_item) do
    correct_tips_count = 3
    correct_tendency_tips_count = 5
    points =
        correct_tips_count * Ggp2.config.correct_tip_points +
            correct_tendency_tips_count * Ggp2.config.correct_tendency_only_tip_points

    RankingItem.new(
        points: points,
        correct_tips_count: correct_tips_count,
        correct_tendency_tips_count: correct_tendency_tips_count)
  end

  let(:tip) { Tip.new match_id: 10, user_id: 11, result: Tip::RESULTS[:incorrect] }

  describe '::build_ranking_item' do

    it 'returns new RankingItem with values based on given tip and previous RankingItem' do
      actual_ranking_item = subject.build(tip, previous_ranking_item)

      expect(actual_ranking_item.user_id).to eq tip.user_id
      expect(actual_ranking_item.match_id).to eq tip.match_id
      expect(actual_ranking_item.points).to eq previous_ranking_item.points
      expect(actual_ranking_item.correct_tips_count).to eq previous_ranking_item.correct_tips_count
      expect(actual_ranking_item.correct_tendency_tips_count).to eq previous_ranking_item.correct_tendency_tips_count
      expect(actual_ranking_item.correct_champion_tip).to be_nil
    end

    context 'when tip is correct' do

      it 'returns RankingItem with new correct tip and point values' do
        tip.result = Tip::RESULTS[:correct]

        actual_ranking_item = subject.build(tip, previous_ranking_item)
        expect(actual_ranking_item.points).
            to eq previous_ranking_item.points + Ggp2.config.correct_tip_points
        expect(actual_ranking_item.correct_tips_count).
            to eq previous_ranking_item.correct_tips_count + 1
        expect(actual_ranking_item.correct_tendency_tips_count).
            to eq previous_ranking_item.correct_tendency_tips_count
      end
    end

    context 'when tip has only correct tendency' do

      it 'returns ranking item with new correct tip and point values' do
        tip.result = Tip::RESULTS[:correct_tendency_only]

        actual_ranking_item = subject.build(tip, previous_ranking_item)
        expect(actual_ranking_item.points).
            to eq previous_ranking_item.points + Ggp2.config.correct_tendency_only_tip_points
        expect(actual_ranking_item.correct_tips_count).
            to eq previous_ranking_item.correct_tips_count
        expect(actual_ranking_item.correct_tendency_tips_count).
            to eq previous_ranking_item.correct_tendency_tips_count + 1
      end
    end

    context 'when tip has correct tendency with correct score difference' do

      it 'returns ranking item with new correct tip and point values' do
        tip.result = Tip::RESULTS[:correct_tendency_with_score_difference]

        actual_ranking_item = subject.build(tip, previous_ranking_item)
        expect(actual_ranking_item.points).
            to eq previous_ranking_item.points + Ggp2.config.correct_tendency_with_score_difference_tip_points
        expect(actual_ranking_item.correct_tips_count).
            to eq previous_ranking_item.correct_tips_count
        expect(actual_ranking_item.correct_tendency_tips_count).
            to eq previous_ranking_item.correct_tendency_tips_count + 1
      end
    end

    context 'when tip has correct tendency with one correct score' do

      it 'returns ranking item with new correct tip and point values' do
        tip.result = Tip::RESULTS[:correct_tendency_with_one_score]

        actual_ranking_item = subject.build(tip, previous_ranking_item)
        expect(actual_ranking_item.points).
            to eq previous_ranking_item.points + Ggp2.config.correct_tendency_with_one_score_tip_points
        expect(actual_ranking_item.correct_tips_count).
            to eq previous_ranking_item.correct_tips_count
        expect(actual_ranking_item.correct_tendency_tips_count).
            to eq previous_ranking_item.correct_tendency_tips_count + 1
      end
    end
  end
end
