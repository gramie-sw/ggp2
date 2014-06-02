describe TipBadge do

  subject { TipBadge.new(result: 'correct', count: 3, position: 1, icon: 'icon', icon_color: 'icon_color', identifier: 'identifier')}

  it { should respond_to(:result=, :result) }
  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.result).to eq 'correct'
      expect(subject.count).to eq 3
      expect(subject.position).to eq 1
      expect(subject.icon).to eq 'icon'
      expect(subject.icon_color).to eq 'icon_color'
      expect(subject.identifier).to eq 'identifier'
    end
  end

  describe '#eligible_user_ids' do

    it 'should return all user ids which have at least count result tips' do

      user_ids = instance_double('Hash')

      expect(subject.result).to receive(:to_sym).and_call_original
      expect(Tip).to receive(:user_ids_with_at_least_result_tips).with(result: Tip::RESULTS[:correct],
                                                                       count: subject.count).and_return(user_ids)
      actual_user_ids = subject.eligible_user_ids
      expect(actual_user_ids).to be user_ids
    end
  end
end