describe ChampionTipRankingItemFactory do

  subject { ChampionTipRankingItemFactory }

  describe '::build' do

    let(:previous_ranking_item) do
      RankingItem.new(
          user_id: 3,
          points: 55,
          correct_tips_count: 7,
          correct_tendency_tips_only_count: 12,
      )
    end

    context 'should when given champion_tip was correct' do

      let(:champion_tip) { ChampionTip.new(result: ChampionTip::RESULTS[:correct]) }

      it 'should return new RankingItem with updated points and correct_champion_tip' do

        actual_ranking_item = subject.build(champion_tip, previous_ranking_item)
        actual_ranking_item.user_id.should eq previous_ranking_item.user_id
        actual_ranking_item.points.should eq previous_ranking_item.points + Ggp2.config.correct_champion_points
        actual_ranking_item.correct_tips_count.should eq previous_ranking_item.correct_tips_count
        actual_ranking_item.correct_tendency_tips_only_count.should eq previous_ranking_item.correct_tendency_tips_only_count
        actual_ranking_item.correct_champion_tip.should be_true
      end
    end

    context 'should when given champion_tip was correct' do

      let(:champion_tip) { ChampionTip.new(result: ChampionTip::RESULTS[:incorrect]) }

      it 'should return new RankingItem having identical fields to previous one' do

        actual_ranking_item = subject.build(champion_tip, previous_ranking_item)
        actual_ranking_item.user_id.should eq previous_ranking_item.user_id
        actual_ranking_item.points.should eq previous_ranking_item.points
        actual_ranking_item.correct_tips_count.should eq previous_ranking_item.correct_tips_count
        actual_ranking_item.correct_tendency_tips_only_count.should eq previous_ranking_item.correct_tendency_tips_only_count
        actual_ranking_item.correct_champion_tip.should be_false
      end
    end
  end
end