describe RankingItemFactory do

  let(:previous_ranking_item) { build(:ranking_item, correct_tips_count: 3, correct_tendency_tips_only_count: 5) }
  let(:tip) { build(:tip, match_id: 10, user_id: 11) }

  describe 'build_ranking_item' do

    it 'should return new ranking item with values set' do
      build_ranking_item = subject.build_ranking_item(previous_ranking_item, tip)
      build_ranking_item.user_id.should eq tip.user_id
      build_ranking_item.match_id.should eq tip.match_id
    end

    context 'if correct tip' do
      it 'should return ranking item with correct tip count incremented' do
        tip.stub(:result).and_return(Tip::RESULTS[:correct])
        build_ranking_item = subject.build_ranking_item(previous_ranking_item, tip)
        build_ranking_item.correct_tips_count.should eq previous_ranking_item.correct_tips_count + 1
        build_ranking_item.correct_tendency_tips_only_count.should eq previous_ranking_item.correct_tendency_tips_only_count
      end
    end

    context 'if correct tendency tip' do
      it 'should return ranking item with correct tendency tip count incremented' do
        tip.stub(:result).and_return(Tip::RESULTS[:correct_tendency])
        build_ranking_item = subject.build_ranking_item(previous_ranking_item, tip)
        build_ranking_item.correct_tips_count.should eq previous_ranking_item.correct_tips_count
        build_ranking_item.correct_tendency_tips_only_count.should eq previous_ranking_item.correct_tendency_tips_only_count + 1
      end
    end

    it 'should set points accumulate correct tip and correct tendency tip' do
      build_ranking_item = subject.build_ranking_item(previous_ranking_item, tip)
      build_ranking_item.points.should eq build_ranking_item.correct_tips_count + build_ranking_item.correct_tendency_tips_only_count
    end
  end
end