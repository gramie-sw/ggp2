describe TipConsecutiveMissedBadge do

  subject { TipConsecutiveMissedBadge.new(position: 1, icon: 'icon', icon_color: 'icon_color', count: 2)}

  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do

      expect(subject.position).to eq 1
      expect(subject.icon).to eq 'icon'
      expect(subject.icon_color).to eq 'icon_color'
      expect(subject.count).to eq 2
    end
  end

  describe '#eligible_user_ids' do

    it 'should return all user ids which have at least count consecutive missed tips' do

      expect(Tip).to receive(:user_ids_with_at_least_missed_tips).with(count: 2).and_return([2,3,4])

      expect(Tip).to receive(:ordered_results_having_finished_match_by_user_id).with(2).and_return(
                         [nil, Tip::RESULTS[:incorrect], nil, nil])
      expect(Tip).to receive(:ordered_results_having_finished_match_by_user_id).with(3).and_return(
                         [nil, Tip::RESULTS[:incorrect], nil])
      expect(Tip).to receive(:ordered_results_having_finished_match_by_user_id).with(4).and_return(
                         [nil, nil, nil])

      actual_user_ids = subject.eligible_user_ids
      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include(2,4)
    end
  end

  describe '#identifier' do

    it 'should return symbolized underscored class name with count value appended' do
      expect(subject.identifier).to eq :tip_consecutive_missed_badge_2
    end
  end
end