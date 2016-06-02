describe TipConsecutiveMissedBadge do

  subject { TipConsecutiveMissedBadge.new(icon: 'icon', color: 'gold', achievement: 2) }

  it { is_expected.to be_a Badge }

  describe '#eligible_user_ids' do

    it 'returns all user ids which have at least count consecutive missed tips' do

      user_ids = [1, 2, 3, 4]

      expect(TipQueries).to receive(:user_ids_with_at_least_result_tips).with(result: Tip::RESULTS[:missed],
                         user_ids: user_ids, count: subject.achievement) { [2, 3, 4] }

      expect(TipQueries).to receive(:match_position_ordered_results).with(2).and_return(
                         [nil, Tip::RESULTS[:incorrect], Tip::RESULTS[:missed], Tip::RESULTS[:missed], nil])
      expect(TipQueries).to receive(:match_position_ordered_results).with(3).and_return(
                         [nil, Tip::RESULTS[:incorrect], nil])
      expect(TipQueries).to receive(:match_position_ordered_results).with(4).and_return(
                         [nil, Tip::RESULTS[:missed], nil, Tip::RESULTS[:missed]])

      actual_user_ids = subject.eligible_user_ids user_ids
      expect(actual_user_ids.size).to eq 1
      expect(actual_user_ids).to include(2)
    end
  end
end