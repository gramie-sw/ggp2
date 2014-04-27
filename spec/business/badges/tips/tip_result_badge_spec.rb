describe TipResultBadge do

  subject { TipResultBadge.new(result: 'correct', count: 3)}

  it { should respond_to(:result=, :result) }
  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.result).to eq 'correct'
      expect(subject.count).to eq 3
    end
  end

  describe '#eligible_user_ids' do

  end

  describe 'identifier' do
    it 'should return symbolized underscored class name with result and count value appended' do
      expect(subject.identifier).to eq :tip_result_badge_correct_3
    end
  end
end