describe UserTipsShowPresenter do

  let(:user) { create(:player) }
  subject { UserTipsShowPresenter.new(user: user, user_is_current_user: true) }

  describe '#title' do

    context 'if user is current_user' do
      it { subject.title.should eq t('general.your_tips') }
    end

    context 'if user is not current_user' do
      subject { UserTipsShowPresenter.new(user: user, user_is_current_user: false) }
      it { subject.title.should eq t('general.tips_of', name: user.nickname) }
    end
  end

  describe '#phases' do

    it '#should return all phases' do
      Aggregate.should_receive(:phases).and_call_original
      subject.phases
    end

    it 'should order phased by position' do
      relation = double('AggregateRelation')
      relation.should_receive(:order_by_position)
      Aggregate.stub(:phases).and_return(relation)
      subject.phases
    end

    it 'should cache phases' do
      subject.phases.should be subject.phases
    end
  end

  describe '#match_presenters_of' do

    it 'should return match_presenters for given aggregate' do
      phase = create(:phase)
      match_1 = create(:match, aggregate: phase)
      match_2 = create(:match, aggregate: phase)
      create(:match)

      actual_match_presenters = subject.match_presenters_of(phase)
      actual_match_presenters.count.should eq 2
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations 2.14.4
      actual_match_presenters.first.kind_of?(MatchPresenter).should be_true
      actual_match_presenters.second.kind_of?(MatchPresenter).should be_true
      actual_match_presenters.first.match.should eq match_1
      actual_match_presenters.second.match.should eq match_2
    end

    let(:aggregate) { create(:aggregate) }
    let(:relation) do
      relation = double('AggregateRelation')
      relation.as_null_object
      relation
    end

    before :each do
      aggregate.stub(:matches_including_of_children).and_return(relation)
    end

    it 'should return also matches of children of given aggregate' do
      aggregate.should_receive(:matches_including_of_children).and_return(relation)
      subject.match_presenters_of(aggregate)
    end

    it 'should order matches by position' do
      relation.should_receive(:order_by_position).and_return(relation)
      subject.match_presenters_of(aggregate)
    end

    it 'should include team_1 and team_2' do
      relation.should_receive(:includes).with(:team_1, :team_2).and_return(relation)
      subject.match_presenters_of(aggregate)
    end
  end

end