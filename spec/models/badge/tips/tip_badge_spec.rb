describe TipBadge do

  subject { TipBadge.new(result: 'correct', icon: 'icon', color: 'gold') }

  it { is_expected.to be_a Badge }

  it { is_expected.to respond_to(:result=, :result) }


  describe '#group_identifier' do
    it 'returns group_identifier' do
      expect(subject.group_identifier).to eq('tip_badge#correct')
    end
  end


  describe '#eligible_user_ids' do

    it 'returns all user ids which having at least count result tips by given user_ids' do

      user_ids = instance_double('Hash')
      actual_user_ids = instance_double('Hash')

      expect(subject.result).to receive(:to_sym).and_call_original
      expect(Tip).to receive(:user_ids_with_at_least_result_tips).with(
                         result: Tip::RESULTS[:correct],
                         user_ids: user_ids,
                         count: subject.achievement).and_return(actual_user_ids)

      expect(subject.eligible_user_ids(user_ids)).to eq actual_user_ids
    end
  end
end