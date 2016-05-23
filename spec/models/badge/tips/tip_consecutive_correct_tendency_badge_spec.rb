describe TipConsecutiveCorrectTendencyBadge do

  subject { TipConsecutiveCorrectTendencyBadge.new(icon: 'icon', color: 'gold', achievement: 3) }

  it { is_expected.to be_a Badge }

  describe '#eligible_user_ids' do

    it 'returns all user ids which have at least count consecutive correct tendency tips' do

      user_ids = [1, 2, 3, 4, 5]
      results = [
          Tip::RESULTS[:correct_tendency_only],
          Tip::RESULTS[:correct_tendency_with_score_difference],
          Tip::RESULTS[:correct_tendency_with_one_score]
      ]

      expect(TipQueries).to receive(:user_ids_with_at_least_result_tips).with(result: results,
                                                                              user_ids: user_ids, count: subject.achievement) { [2, 3, 4, 5] }

      expect(TipQueries).to receive(:finished_match_position_ordered_results).with(2).and_return(
          [nil, Tip::RESULTS[:correct_tendency_only], Tip::RESULTS[:correct_tendency_only], Tip::RESULTS[:missed]])
      expect(TipQueries).to receive(:finished_match_position_ordered_results).with(3).and_return(
          [nil, Tip::RESULTS[:correct_tendency_only], Tip::RESULTS[:correct_tendency_with_score_difference], Tip::RESULTS[:correct_tendency_with_one_score]])
      expect(TipQueries).to receive(:finished_match_position_ordered_results).with(4).and_return(
          [Tip::RESULTS[:correct_tendency_with_one_score], Tip::RESULTS[:correct_tendency_with_one_score], Tip::RESULTS[:correct_tendency_with_one_score], nil])
      expect(TipQueries).to receive(:finished_match_position_ordered_results).with(5).and_return(
          [Tip::RESULTS[:correct_tendency_with_one_score], Tip::RESULTS[:correct_tendency_only], Tip::RESULTS[:correct_tendency_with_one_score], nil])

      actual_user_ids = subject.eligible_user_ids user_ids
      expect(actual_user_ids.size).to eq 3
      expect(actual_user_ids).to include(3, 4, 5)
    end
  end
end