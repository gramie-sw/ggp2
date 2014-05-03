describe TipBadge do

  subject { TipBadge.new(result: 'correct', count: 3)}

  it { should respond_to(:result=, :result) }
  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.result).to eq 'correct'
      expect(subject.count).to eq 3
    end
  end

  describe '#eligible_user_ids' do

    it 'should return all user ids which have at least count result tips' do

      expect(Tip).to receive(:user_ids_with_at_least_result_tips).with(result: Tip::RESULTS[subject.result.to_sym],
                                                                       count: subject.count)
      subject.eligible_user_ids
    end
  end

  describe 'identifier' do
    it 'should return symbolized underscored class name with result and count value appended' do
      expect(subject.identifier).to eq :tip_badge_correct_3
    end
  end
end