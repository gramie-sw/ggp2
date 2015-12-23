describe TipMissedBadge do

  subject { TipMissedBadge.new(icon: 'icon', color: 'gold', achievement: 2) }

  it { is_expected.to be_a Badge }

  describe '#eligible_user_ids' do

    let(:user_ids) { [1,2,3]}

    it 'returns all user ids which have at least count missed tips restricted by given user ids' do
      eligible_user_ids = 'eligible_user_ids'

      expect(Tip).to receive(:user_ids_with_at_least_missed_tips).with(
                         user_ids: user_ids, count: subject.achievement) { eligible_user_ids }

      actual_user_ids = subject.eligible_user_ids user_ids
      expect(actual_user_ids).to be eligible_user_ids
    end
  end
end