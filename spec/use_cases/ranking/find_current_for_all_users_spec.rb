describe Ranking::FindCurrentForAllUsers do

  subject { Ranking::FindCurrentForAllUsers }

  describe 'defaults' do

    it 'page should be one' do
      expect(Ranking::FindCurrentForAllUsers.new.page).to be 1
    end
  end

  describe '#run' do

    users = [User.new(id: 3), User.new(id: 4)]

    let(:page) { 3 }
    let(:per_page) { 10 }

    before :each do
      allow(Ggp2.config).to receive(:user_page_count).and_return(per_page)
    end

    context 'when no RankingSet exist' do

      before :each do
        expect(UserQueries).to respond_to(:all_for_ranking)
        expect(UserQueries).to receive(:all_for_ranking).with(page: page, per_page: per_page).and_return(users)
      end

      it 'should return neutral RankingItems with set user and user_id' do
        actual_ranking_items = subject.run(page: page)

        expect(actual_ranking_items.size).to be 2
        expect(actual_ranking_items.first).to be_instance_of RankingItem
        expect(actual_ranking_items.first).to be_neutral
        expect(actual_ranking_items.first.user_id).to eq users.first.id
        expect(actual_ranking_items.second).to be_instance_of RankingItem
        expect(actual_ranking_items.second).to be_neutral
        expect(actual_ranking_items.second.user_id).to eq users.second.id
      end

      context 'when given page is 1' do

        let(:page) { 1 }

        it 'should set position to RankingItems starting with 1' do
          actual_ranking_items = subject.run(page: page)

          expect(actual_ranking_items.first.position).to eq 1
          expect(actual_ranking_items.second.position).to eq 2
        end
      end

      context 'when given page greater than 1' do

        let(:page) { 2 }

        it 'should set position to RankingItems according given page' do
          actual_ranking_items = subject.run(page: page)

          expect(actual_ranking_items.first.position).to eq 11
          expect(actual_ranking_items.second.position).to eq 12
        end
      end
    end

    context 'when RankingSets exist' do

      match_id = 1224

      before :each do
        expect(Property).to respond_to(:last_tip_ranking_set_match_id)
        allow(Property).to receive(:last_tip_ranking_set_match_id).and_return(match_id)
      end

      context 'when a Tip-RankingSet is the last updated one' do

        it 'returns RankinItems for all last updated Tip-RankingSet' do
          expected_ranking_items = 'ExpectedRankingItems'
          expect(RankingItemQueries).to respond_to(:ranking_set_for_ranking_view_by_match_id)
          expect(RankingItemQueries).to receive(:ranking_set_for_ranking_view_by_match_id).
                                            with(match_id, page: page, per_page: per_page).
                                            and_return(expected_ranking_items)

          expect(subject.run(page: page)).to be expected_ranking_items
        end
      end

      context 'when the ChampionTip-RankingSet is the last updated one' do

        before :each do
          expect(Property).to respond_to(:champion_tip_ranking_set_exists?)
          allow(Property).to receive(:champion_tip_ranking_set_exists?).and_return(true)
        end

        it 'returns RankinItem with for user_id of ChampionTip-RankingSet' do
          expected_ranking_items = 'ExpectedRankingItems'
          expect(RankingItemQueries).to respond_to(:ranking_set_for_ranking_view_by_match_id)
          expect(RankingItemQueries).to receive(:ranking_set_for_ranking_view_by_match_id).
                                            with(nil, page: page, per_page: per_page).
                                            and_return(expected_ranking_items)

          expect(subject.run(page: page)).to be expected_ranking_items
        end
      end
    end
  end
end