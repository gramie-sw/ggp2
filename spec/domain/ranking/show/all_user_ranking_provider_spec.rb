describe AllUserRankingProvider do

  let(:users) do
    [
        User.new(id: 3),
        User.new(id: 4)
    ]
  end
  let(:page) { 3 }
  let(:per_page) { 10 }

  subject { AllUserRankingProvider }

  before :each do
    allow(Ggp2.config).to receive(:user_page_count).and_return(per_page)
  end

  describe 'neutral_ranking' do

    it 'should return neutral RankingItems with set user and user_id' do
      expect(User).to receive(:players_for_ranking_listing).with(page: page, per_page: per_page).and_return(users)
      actual_ranking_items = subject.neutral_ranking(page: page)

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
        expect(User).to receive(:players_for_ranking_listing).with(page: page, per_page: per_page).and_return(users)

        actual_ranking_items = subject.neutral_ranking(page: page)

        expect(actual_ranking_items.first.position).to eq 1
        expect(actual_ranking_items.second.position).to eq 2
      end
    end

    context 'when given page is 2' do

      let(:page) { 2 }

      it 'should set position to RankingItems according given page' do
        expect(User).to receive(:players_for_ranking_listing).with(page: page, per_page: 15).and_return(users)

        expect(Ggp2.config).to receive(:user_page_count).at_least(:once).and_return(15)

        actual_ranking_items = subject.neutral_ranking(page: page)

        expect(actual_ranking_items.first.position).to eq 16
        expect(actual_ranking_items.second.position).to eq 17
      end
    end

    context 'when given page is a String' do
      let(:page) { '1' }

      it 'should cast page to int' do
        expect(User).to receive(:players_for_ranking_listing).with(page: page.to_i, per_page: per_page).and_return(users)

        actual_ranking_items = subject.neutral_ranking(page: page)

        expect(actual_ranking_items.first.position).to eq 1
        expect(actual_ranking_items.second.position).to eq 2
      end
    end

    context 'when given page is null' do
      let(:page) { nil }

      it 'should set page is 1' do
        expect(User).to receive(:players_for_ranking_listing).with(page: 1, per_page: per_page).and_return([])
        subject.neutral_ranking(page: page)
      end
    end

    context 'when given page is 0' do
      let(:page) { nil }

      it 'should set page ot 1' do
        expect(User).to receive(:players_for_ranking_listing).with(page: 1, per_page: per_page).and_return([])
        subject.neutral_ranking(page: page)
      end
    end
  end

  describe '#tip_ranking' do

    let(:expected_ranking_items) { double('RankingItems') }

    it 'should return Tip-RankingItems of RankingItemRepository#ranking_set_for_listing' do
      expect(Ggp2.config).to receive(:user_page_count).and_return(15)
      expect(RankingItem).to receive(:ranking_set_for_listing).with(match_id: 3, page: 2, per_page: 15)

      subject.tip_ranking(match_id: 3, page: 2)
    end
  end

  describe '#champion_tip_ranking' do

    let(:expected_ranking_items) { double('RankingItems') }

    it 'should return ChampionTip-RankingItems of RankingItemRepository#ranking_set_for_listing' do
      expect(Ggp2.config).to receive(:user_page_count).and_return(15)
      expect(RankingItem).to receive(:ranking_set_for_listing).with(match_id: nil, page: 2, per_page: 15)

      subject.champion_tip_ranking(page: 2)
    end
  end
end