describe TipConsecutiveBadge do

  subject { TipConsecutiveBadge.new(result: 'correct', count: 2, position: 1, icon: 'my_icon', icon_color: 'my_color')}

  it { should respond_to(:result=, :result) }
  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.result).to eq 'correct'
      expect(subject.count).to eq 2
      expect(subject.position).to eq 1
      expect(subject.icon).to eq 'my_icon'
      expect(subject.icon_color).to eq 'my_color'
    end
  end

  describe '#eligible_user_ids' do

    it 'should return user_ids having at least count consecutive results' do

      expect(Tip).to receive(:user_ids_with_at_least_result_tips).with(result: Tip::RESULTS[:correct],
                                count: 2).and_return([2,3,4])

      expect(Tip).to receive(:ordered_results_by_user_id).with(2).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:incorrect], Tip::RESULTS[:correct], Tip::RESULTS[:correct]])
      expect(Tip).to receive(:ordered_results_by_user_id).with(3).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:incorrect], Tip::RESULTS[:correct]])
      expect(Tip).to receive(:ordered_results_by_user_id).with(4).and_return(
             [Tip::RESULTS[:correct], Tip::RESULTS[:correct], Tip::RESULTS[:correct]])

      actual_user_ids = subject.eligible_user_ids
      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include(2,4)
    end
  end

  describe '#identifier' do
    it 'should return symbolized underscored class name with result and count value appended' do
      expect(subject.identifier).to eq :tip_consecutive_badge_correct_2
    end
  end
end