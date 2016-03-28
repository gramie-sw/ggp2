describe TipConsecutiveMissedBadge do

  subject { TipConsecutiveMissedBadge.new(icon: 'icon', color: 'gold', achievement: 2) }

  it { is_expected.to be_a Badge }

  describe '#eligible_user_ids' do

    it 'returns all user ids which have at least count consecutive missed tips' do

      user_ids = [1, 2, 3, 4]

      expect(TipQueries).to receive(:user_ids_with_at_least_missed_tips).with(
                         user_ids: user_ids, count: subject.achievement) { [2, 3, 4] }

      expect(TipQueries).to receive(:finished_match_position_ordered_results).with(2).and_return(
                         [nil, Tip::RESULTS[:incorrect], nil, nil])
      expect(TipQueries).to receive(:finished_match_position_ordered_results).with(3).and_return(
                         [nil, Tip::RESULTS[:incorrect], nil])
      expect(TipQueries).to receive(:finished_match_position_ordered_results).with(4).and_return(
                         [nil, nil, nil])

      actual_user_ids = subject.eligible_user_ids user_ids
      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include(2, 4)
    end
  end
end