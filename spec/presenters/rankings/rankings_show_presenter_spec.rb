describe RankingsShowPresenter do

  let(:current_user_id) { 7 }
  let(:tournament) { Tournament.new }
  let(:page) { 1 }
  subject do
    RankingsShowPresenter.new(
        tournament: tournament,
        current_user_id: current_user_id,
        page: page)
  end


  it 'should have ranking_items accessors' do
    expect(subject).to respond_to :ranking_items
    expect(subject).to respond_to :ranking_items=
  end

  describe '#subtitle' do

    it 'should return the subtitle' do
      expect(tournament).to receive(:total_match_count).and_return(64)
      expect(tournament).to receive(:played_match_count).and_return(10)
      expect(subject.subtitle).to eq t('tournament.progress', played_match_count: 10, total_match_count: 64)
    end
  end

  describe '#ranking_items' do

    it 'should have default values ' do
      expect(subject.ranking_items).to eq []
    end
  end

  describe '#user_ranking_presenters' do

    let(:ranking_items) do
      [
          RankingItem.new(position: 5),
          RankingItem.new(position: 6)
      ]
    end

    before :each do
      subject.ranking_items= ranking_items
    end

    it 'should return for all RankingItems a UserRankingPresenter' do

      expect(UserRankingPresenter).to receive(:new).
          with(ranking_item: ranking_items.first, tournament: tournament, current_user_id: current_user_id).
          and_call_original
      expect(UserRankingPresenter).to receive(:new).
          with(ranking_item: ranking_items.second, tournament: tournament, current_user_id: current_user_id).
          and_call_original

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

    context 'when ranking_items= was given an Array' do

      it 'should return players scope' do
        expected_player_scope = double('PlayerScope')
        expect(Ggp2.config).to receive(:user_page_count).and_return(10)
        expect(User).to receive(:players_for_ranking_listing).with(page: page, per_page: 10).and_return(expected_player_scope)
        subject.ranking_items= []
        expect(subject.pagination_scope).to be expected_player_scope
      end
    end

    context 'when ranking_items= was given ' do

      it 'should return the given value' do
        expected_ranking_item_scope = double('RankingItemScope')
        subject.ranking_items= expected_ranking_item_scope
        expect(subject.pagination_scope).to be expected_ranking_item_scope
      end
    end
  end
end