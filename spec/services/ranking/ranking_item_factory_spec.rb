describe RankingItemFactory do

  let(:previous_ranking_item) { build(:ranking_item, correct_tips_count: 3, correct_tendency_tips_only_count: 5) }
  let(:tip) { build(:tip, match_id: 10, user_id: 11) }

  describe 'build_ranking_item' do

    it 'should return new ranking item with values set' do
      build_ranking_item = subject.build_ranking_item(previous_ranking_item, tip)
      build_ranking_item.user_id.should eq tip.user_id
      build_ranking_item.match_id.should eq tip.match_id
    end

    describe 'correct tip' do
      context 'if previous ranking item is set' do
        it 'should return ranking item with correct tip count incremented' do
          tip.stub(:result).and_return(Tip::RESULTS[:correct])
          build_ranking_item = subject.build_ranking_item(previous_ranking_item, tip)
          build_ranking_item.correct_tips_count.should eq previous_ranking_item.correct_tips_count + 1
          build_ranking_item.correct_tendency_tips_only_count.should eq previous_ranking_item.correct_tendency_tips_only_count
        end
      end

      context 'if previous ranking item is not set' do
        it 'should return ranking item with correct tip with value 1' do
          tip.stub(:result).and_return(Tip::RESULTS[:correct])
          build_ranking_item = subject.build_ranking_item(tip)
          build_ranking_item.correct_tips_count.should eq 1
          build_ranking_item.correct_tendency_tips_only_count.should eq 0
        end
      end
    end

    describe 'correct tendency tip' do
      context 'if previous ranking item is set' do
        it 'should return ranking item with correct tendency tip count incremented' do
          tip.stub(:result).and_return(Tip::RESULTS[:correct_tendency])
          build_ranking_item = subject.build_ranking_item(previous_ranking_item, tip)
          build_ranking_item.correct_tips_count.should eq previous_ranking_item.correct_tips_count
          build_ranking_item.correct_tendency_tips_only_count.should eq previous_ranking_item.correct_tendency_tips_only_count + 1
        end
      end
      context 'if previous ranking item is not set' do
        it 'should return ranking item with correct tendency tip count with value 1' do
          tip.stub(:result).and_return(Tip::RESULTS[:correct_tendency])
          build_ranking_item = subject.build_ranking_item(tip)
          build_ranking_item.correct_tips_count.should eq 0
          build_ranking_item.correct_tendency_tips_only_count.should eq 1
        end
      end
    end

    it 'should set points accumulate correct tip and correct tendency tip' do
      build_ranking_item = subject.build_ranking_item(previous_ranking_item, tip)
      build_ranking_item.points.should eq build_ranking_item.correct_tips_count * Ggp2.config.correct_tip_points + build_ranking_item.correct_tendency_tips_only_count * Ggp2.config.correct_tendency_tip_only_points
    end
  end
end