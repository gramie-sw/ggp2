describe ChampionTipRepository do

  subject { ChampionTip }

  describe '::missed_champion_tip_user_ids(user_ids)' do

    let(:user_ids) {
      [
        create(:user),
        create(:user),
        create(:user),
        create(:user)
      ]
    }

    it 'returns missed champion tip user ids by given user ids' do

      create(:champion_tip, team: nil, user: user_ids[0])
      create(:champion_tip, user: user_ids[1])
      create(:champion_tip, team: nil, user: user_ids[2])

      missed_champion_tip_user_ids = subject.missed_champion_tip_user_ids(user_ids)
      expect(missed_champion_tip_user_ids.size).to eq 2
      expect(missed_champion_tip_user_ids).to include(user_ids[0].id, user_ids[2].id)
    end
  end
end