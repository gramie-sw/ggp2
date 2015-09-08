describe RankingPresenter do

  let(:ranking_items) { [RankingItem.new(position: 5), RankingItem.new(position: 6)] }
  let(:current_user_id) { 7 }
  let(:tournament) { Tournament.new }
  let(:page) { 1 }
  subject do
    RankingPresenter.new(
        ranking_items: ranking_items,
        tournament: tournament,
        current_user_id: current_user_id)
  end

  describe '#subtitle' do

    it 'should return the subtitle' do
      expect(tournament).to receive(:total_match_count).and_return(64)
      expect(tournament).to receive(:played_match_count).and_return(10)
      expect(subject.subtitle).to eq t('tournament.progress', played_match_count: 10, total_match_count: 64)
    end
  end

  describe '#user_ranking_presenters' do

    it 'should return for all RankingItems a UserRankingPresenter' do

      expect(UserRankingPresenter).to receive(:new).
                                          with(ranking_item: ranking_items.first,
                                               tournament: tournament,
                                               current_user_id: current_user_id
                                          ).and_call_original
      expect(UserRankingPresenter).to receive(:new).with(
                                          ranking_item: ranking_items.second,
                                          tournament: tournament,
                                          current_user_id: current_user_id
                                      ).and_call_original

      actual_ranking_row_sets = subject.user_ranking_presenters
      expect(actual_ranking_row_sets.count).to eq 2

      expect(actual_ranking_row_sets.first).to be_instance_of UserRankingPresenter
      expect(actual_ranking_row_sets.first.position).to eq 5
      expect(actual_ranking_row_sets.second).to be_instance_of UserRankingPresenter
      expect(actual_ranking_row_sets.second.position).to eq 6
    end

    it 'should cache value' do
      expect(subject.user_ranking_presenters).to be subject.user_ranking_presenters
    end
  end

  describe '#pagination_scope' do

    it 'returns RankingItems' do
      expect(subject.pagination_scope).to be ranking_items
    end
  end
end