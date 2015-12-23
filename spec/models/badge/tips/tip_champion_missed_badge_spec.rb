describe TipChampionMissedBadge do

  subject { TipChampionMissedBadge.new(icon: 'icon', color: 'gold') }

  it { is_expected.to be_a Badge }

  let(:user_ids) {
    [
      create(:user),
      create(:user),
      create(:user)
    ]
  }

  let!(:champion_tips) {
    [
     create(:champion_tip, user: user_ids[0], team_id: nil),
     create(:champion_tip, user: user_ids[1])
    ]
  }

  describe '#eligible_user_ids' do

    context 'when tournament is not started' do

      it 'returns empty array' do
        expect_any_instance_of(Tournament).to receive(:started?).and_return false

        missed_champion_tip_user_ids = subject.eligible_user_ids user_ids
        expect(missed_champion_tip_user_ids).to eq []
      end
    end

    context 'when tournament is started' do

      it 'returns all user_ids with no champion tip' do

        expect_any_instance_of(Tournament).to receive(:started?).and_return true

        missed_champion_tip_user_ids = subject.eligible_user_ids user_ids
        expect(missed_champion_tip_user_ids).to eq [user_ids[0].id]
      end
    end
  end
end