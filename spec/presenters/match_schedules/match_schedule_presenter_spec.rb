describe MatchSchedulePresenter do

  let(:current_aggregate) { Aggregate.new(id: 34) }

  subject { MatchSchedulePresenter.new(current_aggregate: current_aggregate) }

  it { is_expected.to respond_to(:current_aggregate)}

  describe '#current_phase' do

    it 'returns current_aggregate if it is a Phase itself' do
      expect(current_aggregate).to receive(:phase?).and_return(true)
      expect(subject.current_phase).to be current_aggregate
    end

    it 'returns parent of current_aggregate if is is a Group' do
      expect(current_aggregate).to receive(:phase?).and_return(false)
      expect(current_aggregate).to receive(:parent).and_return(:parent)
      expect(subject.current_phase).to be :parent
    end
  end

  describe '#current_group' do

    it 'returns nil is current_aggregate is a Phase' do
      expect(current_aggregate).to receive(:group?).and_return(false)
      expect(subject.current_group).to be_nil
    end

    it 'returns current_aggregate if it is a Group itself' do
      expect(current_aggregate).to receive(:group?).and_return(true)
      expect(subject.current_group).to be current_aggregate
    end
  end

  describe '#all_phases' do

    it 'returns all Phases ordered by position asc' do
      expect(Aggregate).to receive(:all_phases_ordered_by_position_asc).and_return(:phases)
      expect(subject.all_phases).to eq :phases
    end
  end

  describe '#all_groups' do

    it 'returns all groups of current_phase' do
      expect(subject).to receive(:current_phase).and_return(current_aggregate)
      expect(Aggregate).
          to receive(:all_groups_by_phase_id).with(phase_id: current_aggregate.id, sort: :position).and_return(:groups)
      expect(subject.all_groups).to be :groups
    end
  end

  describe '#match_presenters' do

    it 'returns ordered MatchPresenters for all Matches of current_aggregate' do
      matches = [Match.new(id: 876), Match.new(id: 543)]

      expect(Match).
          to receive(:all_by_aggregate_id).
                 with(current_aggregate.id,
                      order: :position,
                      includes: [:team_1, :team_2]).and_return(matches)

      match_presenters = subject.match_presenters
      expect(match_presenters.count).to eq 2
      expect(match_presenters.first).to be_a MatchPresenter
      expect(match_presenters.first.id).to be matches.first.id
      expect(match_presenters.second).to be_a MatchPresenter
      expect(match_presenters.second.id).to be matches.second.id
    end
  end

end