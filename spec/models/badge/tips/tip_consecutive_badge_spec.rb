describe TipConsecutiveBadge do

  subject { TipConsecutiveBadge.new(result: 'correct', icon: 'my_icon', color: 'gold', achievement: 2 )}

  it { is_expected.to be_a Badge }

  it { is_expected.to respond_to(:result=, :result) }

  describe '#group_identifier' do
    it 'returns group_identifier' do
      expect(subject.group_identifier).to eq('tip_consecutive_badge#correct')
    end
  end

  describe '#eligible_user_ids' do

    it 'return user_ids having at least count consecutive results' do
      user_ids = [1,2,3,4,5]

      expect(subject.result).to receive(:to_sym).at_least(1).and_call_original

      expect(Tip).to receive(:user_ids_with_at_least_result_tips).with(result: Tip::RESULTS[:correct], user_ids: user_ids,
                                count: subject.achievement).and_return([2,3,4,5])

      expect(Tip).to receive(:ordered_results_by_user_id).with(2).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:incorrect], Tip::RESULTS[:correct], Tip::RESULTS[:correct]])
      expect(Tip).to receive(:ordered_results_by_user_id).with(3).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:incorrect], Tip::RESULTS[:correct]])
      expect(Tip).to receive(:ordered_results_by_user_id).with(4).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:correct], Tip::RESULTS[:correct]])
      expect(Tip).to receive(:ordered_results_by_user_id).with(5).and_return(
             [Tip::RESULTS[:correct], nil, Tip::RESULTS[:correct]])

      actual_user_ids = subject.eligible_user_ids user_ids
      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include(2,4)
    end
  end
end