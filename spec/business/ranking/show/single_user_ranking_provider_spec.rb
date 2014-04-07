describe SingleUserRankingProvider do

  let(:expected_neutral_ranking_item) { RankingItem.new }
  let(:expected_ranking_item) { RankingItem.new }
  let(:user_id) { 5 }
  subject { SingleUserRankingProvider }

  describe '#neutral_ranking' do

    it 'should return neutral_ranking for specified user' do
      RankingItem.should_receive(:neutral).with(user_id).and_return(expected_neutral_ranking_item)
      subject.neutral_ranking(user_id: user_id).should be expected_neutral_ranking_item
    end
  end

  describe '#tip_ranking' do

    let(:match_id) { 8 }

    context 'when RankingItem for given user_id and match_id exists' do

      it 'should return existing RankingItem' do
        RankingItem.should_receive(:first_by_user_id_and_match_id).with(user_id: user_id, match_id: match_id).
            and_return(expected_ranking_item)
        subject.tip_ranking(user_id: user_id, match_id: match_id).should be expected_ranking_item
      end
    end

    context 'when RankingItem for given user_id and match_id does not exist' do

      it 'should return existing neutral RankingItem' do
        RankingItem.should_receive(:first_by_user_id_and_match_id).with(user_id: user_id, match_id: match_id).ordered.
            and_return(nil)
        RankingItem.should_receive(:neutral).with(user_id).ordered.and_return(expected_neutral_ranking_item)
        subject.tip_ranking(user_id: user_id, match_id: match_id).should be expected_neutral_ranking_item
      end
    end
  end

  describe '#champion_tip' do

    context 'when RankingItem for given user_id and no match_id exists' do

      it 'should return existing RankingItem' do
        RankingItem.should_receive(:first_by_user_id_and_match_id).with(user_id: user_id, match_id: nil).
            and_return(expected_ranking_item)
        subject.champion_tip_ranking(user_id: user_id).should be expected_ranking_item
      end
    end

    context 'when RankingItem for given user_id and with no match_id does not exist' do

      it 'should return existing neutral RankingItem' do
        RankingItem.should_receive(:first_by_user_id_and_match_id).with(user_id: user_id, match_id: nil).ordered.
            and_return(nil)
        RankingItem.should_receive(:neutral).with(user_id).ordered.and_return(expected_neutral_ranking_item)
        subject.champion_tip_ranking(user_id: user_id).should be expected_neutral_ranking_item
      end
    end
  end

end