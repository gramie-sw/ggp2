describe MatchTipsShowPresenter do

  let(:match) { create(:match) }
  let(:current_user) { create(:player) }
  subject { MatchTipsShowPresenter.new(match: match, current_user_id: current_user.id) }

  describe '#tip_presenters' do
    let(:tips) { (1..3).map { |i| create(:tip, match: match, user: i == 1 ? current_user : create(:player)) } }
    let(:users) { tips.map { |tip| tip.user } }

    before :each do
      users
    end

    it 'should return tip_presenters' do
      actual_tip_presenters = subject.tip_presenters
      expect(actual_tip_presenters.count).to eq 3
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations
      expect(actual_tip_presenters.first.kind_of?(TipPresenter)).to be_truthy
      expect(tips).to include actual_tip_presenters.first.__getobj__
    end

    it 'should set correct is_for_current_user argument when creating TipPresenters' do
      expect(TipPresenter).to receive(:new).with(tip: tips.first, is_for_current_user: true)
      expect(TipPresenter).to receive(:new).with(tip: tips.second, is_for_current_user: false)
      expect(TipPresenter).to receive(:new).with(tip: tips.third, is_for_current_user: false)
      subject.tip_presenters
    end

    it 'should cache tip_presenters' do
      expect(subject.tip_presenters).to eq subject.tip_presenters
    end
  end

  describe '#paginated_ordered_players_for_a_match' do

    let(:relation) do
      relation = double('UserRelation')
      relation.as_null_object
      relation
    end


    it 'returns players with given match ordered and paginated' do
      expect(UserQueries).to receive(:players_ordered_by_nickname_asc_for_a_match_paginated).
          with(match_id: match.id, page: subject.page).and_return(relation)

      expect(subject.paginated_ordered_players_for_a_match).to eq relation
    end
  end

  describe '#match_presenter' do

    it 'should return MatchPresenter of given match' do
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations
      expect(subject.match_presenter.kind_of?(MatchPresenter)).to be_truthy
      expect(subject.match_presenter.__getobj__).to be match
    end

    it 'should cache match_presenter' do
      #matcher be didn't worked with DelegateClass in rspec-expectations
      expect(subject.match_presenter.object_id).to eq subject.match_presenter.object_id
    end
  end
end