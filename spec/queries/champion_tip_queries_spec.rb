describe ChampionTipQueries do

  subject { ChampionTipQueries }

  describe '::clear_all_results' do

    it 'clears the result of all ChampionTips' do
      champion_tips = [ChampionTip.create_unvalidated(result: 1),
                       ChampionTip.create_unvalidated(result: 0)]

      subject.clear_all_results

      champion_tips.each do |champion_tip|
        champion_tip.reload
        expect(champion_tip.result).to be_nil
      end
    end
  end

  describe '::missed_champion_tip_user_ids(user_ids)' do

    let(:players) { (1..4).map { create(:player) } }

    it 'returns missed champion tip user ids by given user ids' do

      create(:champion_tip, team: nil, user: players[0])
      create(:champion_tip, user: players[1])
      create(:champion_tip, team: nil, user: players[2])

      missed_champion_tip_user_ids = subject.missed_champion_tip_user_ids(players.map(&:id))
      expect(missed_champion_tip_user_ids.size).to be 2
      expect(missed_champion_tip_user_ids).to include(players[0].id, players[2].id)
    end
  end
end