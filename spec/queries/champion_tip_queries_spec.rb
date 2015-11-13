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
end