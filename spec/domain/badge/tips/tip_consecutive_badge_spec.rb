describe TipConsecutiveBadge do

  subject { TipConsecutiveBadge.new(result: 'correct', count: 2, position: 1, icon: 'my_icon',
                                    icon_color: 'my_color', identifier: 'identifier')}

  it { is_expected.to respond_to(:result=, :result) }
  it { is_expected.to respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.result).to eq 'correct'
      expect(subject.count).to eq 2
      expect(subject.position).to eq 1
      expect(subject.icon).to eq 'my_icon'
      expect(subject.icon_color).to eq 'my_color'
      expect(subject.identifier).to eq 'identifier'
    end
  end

  describe '#eligible_user_ids' do

    it 'should return user_ids having at least count consecutive results' do

      expect(subject.result).to receive(:to_sym).at_least(1).and_call_original

      expect(Tip).to receive(:user_ids_with_at_least_result_tips).with(result: Tip::RESULTS[:correct],
                                count: 2).and_return([2,3,4,5])

      expect(Tip).to receive(:ordered_results_by_user_id).with(2).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:incorrect], Tip::RESULTS[:correct], Tip::RESULTS[:correct]])
      expect(Tip).to receive(:ordered_results_by_user_id).with(3).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:incorrect], Tip::RESULTS[:correct]])
      expect(Tip).to receive(:ordered_results_by_user_id).with(4).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:correct], Tip::RESULTS[:correct]])
      expect(Tip).to receive(:ordered_results_by_user_id).with(5).and_return(
             [Tip::RESULTS[:correct], nil, Tip::RESULTS[:correct]])

      actual_user_ids = subject.eligible_user_ids
      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include(2,4)
    end
  end
end