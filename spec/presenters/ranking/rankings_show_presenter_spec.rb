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
    subject.should respond_to :ranking_items
    subject.should respond_to :ranking_items=
  end

  describe '#ranking_items' do

    it 'should have default values ' do
      subject.ranking_items.should eq []
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

      UserRankingPresenter.should_receive(:new).
          with(ranking_item: ranking_items.first, tournament: tournament, current_user_id: current_user_id).
          and_call_original
      UserRankingPresenter.should_receive(:new).
          with(ranking_item: ranking_items.second, tournament: tournament, current_user_id: current_user_id).
          and_call_original

      actual_ranking_row_sets = subject.user_ranking_presenters
      actual_ranking_row_sets.count.should eq 2

      actual_ranking_row_sets.first.should be_instance_of UserRankingPresenter
      actual_ranking_row_sets.first.position.should eq 5
      actual_ranking_row_sets.second.should be_instance_of UserRankingPresenter
      actual_ranking_row_sets.second.position.should eq 6
    end

    it 'should cache value' do
      subject.user_ranking_presenters.should be subject.user_ranking_presenters
    end
  end

  describe '#pagination_scope' do

    context 'when ranking_items= was given an Array' do

      it 'should return players scope' do
        expected_player_scope = double('PlayerScope')
        Ggp2.config.should_receive(:ranking_user_page_count).and_return(10)
        User.should_receive(:players_paginated).with(page: page, per_page: 10).and_return(expected_player_scope)
        subject.ranking_items= []
        subject.pagination_scope.should be expected_player_scope
      end
    end

    context 'when ranking_items= was given ' do

      it 'should return the given value' do
        expected_ranking_item_scope = double('RankingItemScope')
        subject.ranking_items= expected_ranking_item_scope
        subject.pagination_scope.should be expected_ranking_item_scope
      end
    end
  end
end