describe AllUserRankingProvider do

  let(:users) do
    [
        User.new(id: 3),
        User.new(id: 4)
    ]
  end
  let(:page) { 3 }

  subject { AllUserRankingProvider }

  describe 'neutral_ranking' do

    it 'should return neutral RankingItems with set user and user_id' do
      User.should_receive(:players_paginated).with(page).and_return(users)
      actual_ranking_items = subject.neutral_ranking(page: page)

      actual_ranking_items.first.should be_instance_of RankingItem
      actual_ranking_items.first.should be_neutral
      actual_ranking_items.first.user_id.should eq users.first.id
      actual_ranking_items.second.should be_instance_of RankingItem
      actual_ranking_items.second.should be_neutral
      actual_ranking_items.second.user_id.should eq users.second.id
    end


    context 'when given page is 1' do

      let(:page) { 1 }

      it 'should set position to RankingItems starting with 1' do
        User.should_receive(:players_paginated).with(page).and_return(users)


        actual_ranking_items = subject.neutral_ranking(page: page)

        actual_ranking_items.first.position.should eq 1
        actual_ranking_items.second.position.should eq 2
      end
    end

    context 'when given pae is 2' do

      let(:page) { 2 }

      it 'should set position to RankingItems according given page' do
        User.should_receive(:players_paginated).with(page).and_return(users)

        Ggp2.config.should_receive(:ranking_user_page_count).at_least(:once).and_return(15)

        actual_ranking_items = subject.neutral_ranking(page: page)

        actual_ranking_items.first.position.should eq 16
        actual_ranking_items.second.position.should eq 17
      end
    end

    context 'when given page is null' do
      let(:page) { nil }

      it 'should set page is 1' do
        User.should_receive(:players_paginated).with(1).and_return([])
        subject.neutral_ranking(page: page)
      end
    end

    context 'when given page is 0' do
      let(:page) { nil }

      it 'should set page ot 1' do
        User.should_receive(:players_paginated).with(1).and_return([])
        subject.neutral_ranking(page: page)
      end
    end
  end
end