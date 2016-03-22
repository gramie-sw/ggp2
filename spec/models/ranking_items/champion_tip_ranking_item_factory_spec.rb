describe ChampionTipRankingItemFactory do

  subject { ChampionTipRankingItemFactory }

  describe '::build' do

    let(:previous_ranking_item) do
      RankingItem.new(
          user_id: 3,
          points: 55,
          correct_tips_count: 7,
          correct_tendency_tips_count: 12,
      )
    end

    context 'should when given champion_tip was correct' do

      let(:champion_tip) { ChampionTip.new(result: ChampionTip::RESULTS[:correct]) }

      it 'should return new RankingItem with updated points and correct_champion_tip' do

        actual_ranking_item = subject.build(champion_tip, previous_ranking_item)
        expect(actual_ranking_item.user_id).to eq previous_ranking_item.user_id
        expect(actual_ranking_item.points).to eq previous_ranking_item.points + Ggp2.config.correct_champion_tip_points
        expect(actual_ranking_item.correct_tips_count).to eq previous_ranking_item.correct_tips_count
        expect(actual_ranking_item.correct_tendency_tips_count).to eq previous_ranking_item.correct_tendency_tips_count
        expect(actual_ranking_item.correct_champion_tip).to be_truthy
      end
    end

    context 'should when given champion_tip was correct' do

      let(:champion_tip) { ChampionTip.new(result: ChampionTip::RESULTS[:incorrect]) }

      it 'should return new RankingItem having identical fields to previous one' do

        actual_ranking_item = subject.build(champion_tip, previous_ranking_item)
        expect(actual_ranking_item.user_id).to eq previous_ranking_item.user_id
        expect(actual_ranking_item.points).to eq previous_ranking_item.points
        expect(actual_ranking_item.correct_tips_count).to eq previous_ranking_item.correct_tips_count
        expect(actual_ranking_item.correct_tendency_tips_count).to eq previous_ranking_item.correct_tendency_tips_count
        expect(actual_ranking_item.correct_champion_tip).to be_falsey
      end
    end
  end
end