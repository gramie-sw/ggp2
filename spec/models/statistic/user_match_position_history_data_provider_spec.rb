describe UserMatchPositionHistoryDataProvider do

  subject { UserMatchPositionHistoryDataProvider.new(user_id) }

  let(:matches) do
    [Match.new(id: 101, position: 1),
     Match.new(id: 102, position: 2),
     Match.new(id: 103, position: 3),
     Match.new(id: 104, position: 5)]
  end

  let(:ranking_items) do
    [RankingItem.new(match_id: matches[1].id, position: 8),
     RankingItem.new(match_id: matches[0].id, position: 2),
     RankingItem.new(match_id: matches[2].id, position: 4),
     RankingItem.new(match_id: matches[3].id, position: 9)]
  end

  let(:user_id) {669}

  describe '#provide' do

    before :each do
      expect(MatchQueries).to receive(:all_matches_with_result_ordered_by_position).and_return(matches)
      expect(RankingItemQueries).to receive(:all_by_user_id).with(user_id).and_return(ranking_items)
    end

    it 'returns match position history data for user' do
      expect(subject.provide).to eq [[1,2],[2,8],[3,4],[5,9]]
    end

    it 'replaces missing RankingItem#position with player count number' do
      expect(UserQueries).to receive(:player_count).and_return(18)
      matches << Match.new(id: 105, position: 6)

      expect(subject.provide).to eq [[1,2],[2,8],[3,4],[5,9],[6,18]]
    end

    it 'uses position of tip RankingItem for last position if it exists' do
      matches << Match.new(id: 105, position: 6)
      ranking_items << RankingItem.new(match_id: 105, position: 9)
      ranking_items << RankingItem.new(match_id: nil, position: 2)

      expect(subject.provide).to eq [[1,2],[2,8],[3,4],[5,9],[6,2]]
    end
  end
end