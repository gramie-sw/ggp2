describe MatchRepresentable  do

  subject do
    subject_object = Object.new.extend MatchRepresentable
    subject_object.instance_variable_set(:@match_presenters, [])
    subject_object
  end

  describe '#phases' do
    it 'should return all phases' do
      expect(Aggregate).to receive(:phases).and_call_original
      subject.phases
    end

    it 'should order by position' do
      relation = double('AggregateRelation')
      expect(relation).to receive(:order_by_position_asc)
      allow(Aggregate).to receive(:phases).and_return(relation)
      subject.phases
    end

    it 'should cache phases' do
      expect(subject.phases).to be subject.phases
    end
  end

  describe '#match_presenters_of' do
    it 'should return match_presenters for given aggregate' do
      phase = create(:phase)
      match_1 = create(:match, aggregate: phase)
      match_2 = create(:match, aggregate: phase)
      create(:match)

      actual_match_presenters = subject.match_presenters_of(phase)
      expect(actual_match_presenters.count).to eq 2
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations 2.14.4
      expect(actual_match_presenters.first.kind_of?(MatchPresenter)).to be_truthy
      expect(actual_match_presenters.first.__getobj__).to eq match_1
      expect(actual_match_presenters.second.kind_of?(MatchPresenter)).to be_truthy
      expect(actual_match_presenters.second.__getobj__).to eq match_2
    end

    let(:aggregate) { create(:aggregate) }
    let(:relation) do
      relation = double('AggregateRelation')
      relation.as_null_object
      relation
    end

    before :each do
      allow(aggregate).to receive(:matches_including_of_children).and_return(relation)
    end

    it 'should return also matches of children of given aggregate' do
      expect(aggregate).to receive(:matches_including_of_children).and_return(relation)
      subject.match_presenters_of(aggregate)
    end

    it 'should order matches by position' do
      expect(relation).to receive(:order_by_position_asc).and_return(relation)
      subject.match_presenters_of(aggregate)
    end

    it 'should include team_1 and team_2' do
      expect(relation).to receive(:includes).with(:team_1, :team_2).and_return(relation)
      subject.match_presenters_of(aggregate)
    end
  end
end