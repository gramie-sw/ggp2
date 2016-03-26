describe MatchQueries do

  describe '::all_by_aggregate_id' do

    context 'if aggregate is a group' do

      it 'returns all associated matches sorted by given order' do
        group = create(:group)
        match_3 = create(:match, aggregate: group, position: 3)
        match_1 = create(:match, aggregate: group, position: 1)
        match_2 = create(:match, aggregate: group, position: 2)
        create(:match, position: 4)

        actual_matches = subject.all_by_aggregate_id(group.id, order: :position)
        expect(actual_matches).to eq [match_1, match_2, match_3]

      end

      context 'if aggregate is a phase with no groups' do

        it 'returns all associated matches sorted by given order' do
          phase = create(:phase)
          match_3 = create(:match, aggregate: phase, position: 3)
          match_1 = create(:match, aggregate: phase, position: 1)
          match_2 = create(:match, aggregate: phase, position: 2)
          create(:match, position: 4)

          actual_matches = subject.all_by_aggregate_id(phase.id, order: :position)
          expect(actual_matches).to eq [match_1, match_2, match_3]

        end
      end

      context 'if aggregate is a phase with groups' do

        it 'returns all matches of all groups sorted by given order' do
          phase = create(:phase)
          group_1 = create(:group, parent: phase)
          group_2 = create(:group, parent: phase)
          match_3 = create(:match, aggregate: group_1, position: 3)
          match_1 = create(:match, aggregate: group_1, position: 1)
          match_4 = create(:match, aggregate: group_2, position: 4)
          match_2 = create(:match, aggregate: group_2, position: 2)
          create(:match, position: 5)

          actual_matches = subject.all_by_aggregate_id(phase.id, order: :position)
          expect(actual_matches).to eq [match_1, match_2, match_3, match_4]
        end
      end
    end

    it 'includes specified associations if given' do
      phase = create(:phase)

      relation = double('relation')
      relation.as_null_object
      expect(Match).to receive(:where).and_return(relation)
      expect(relation).to receive(:includes).with(:team_1, :team_2).and_return(relation)

      subject.all_by_aggregate_id(phase.id, order: :position, includes: [:team_1, :team_2])
    end
  end

  describe '::all_match_ids_ordered_by_position' do

    let!(:matches) do
      [
          Match.create_unvalidated(position: 3),
          Match.create_unvalidated(position: 1),
          Match.create_unvalidated(position: 2)
      ]
    end

    it 'returns all match_ids order by position' do
      expect(subject.all_match_ids_ordered_by_position).to eq [matches[1].id, matches[2].id, matches[0].id]
    end
  end

  describe '::matches_with_aggregates' do

    let(:aggregates) { (1..2).map { create(:aggregate) } }

    it 'returns all matches having given aggregates' do

      match_1 = create(:match, aggregate: aggregates.first)
      match_2 = create(:match, aggregate: aggregates.second)
      create(:match)

      actual_matches = MatchQueries.matches_with_aggregates(aggregates)
      expect(actual_matches.size).to be 2
      expect(actual_matches).to include match_1, match_2
    end
  end

  describe '::count_all_with_results' do

    it 'returns count of all matches with result' do
      create(:match, score_team_1: nil, score_team_2: nil)
      create(:match, score_team_1: 0, score_team_2: 2)
      create(:match, score_team_1: 1, score_team_2: 1)

      expect(MatchQueries.count_all_with_results).to eq 2
    end
  end

  describe '::first_match' do

    it 'returns first match' do
      create(:match, position: 3)
      match_1 = create(:match, position: 1)
      create(:match, position: 2)

      expect(MatchQueries.first_match).to eq match_1
    end
  end

  describe '::future_matches' do

    it 'returns only future matches' do

      match_1 = create(:match, date: 2.minutes.from_now)
      match_2 = create(:match, date: 3.minutes.from_now)
      create(:match, date: 1.minutes.ago)

      actual_matches = MatchQueries.future_matches
      expect(actual_matches.count).to eq 2
      expect(actual_matches).to include match_1, match_2
    end
  end

  describe '::last_match' do

    it 'returns last match' do
      match_3 = create(:match, position: 3)
      create(:match, position: 1)
      create(:match, position: 2)

      expect(MatchQueries.last_match).to eq match_3
    end
  end

  describe '::next_match' do

    it 'returns next match' do
      create(:match, date: 4.days.from_now)
      create(:match, date: 1.days.ago)
      expected_match = create(:match, date: 3.days.from_now)

      expect(MatchQueries.next_match).to eq expected_match
    end
  end

  describe '::order_by_date_asc' do

    it 'returns matches ordered by date asc' do
      match_3 = create(:match, date: 4.days.from_now)
      match_1 = create(:match, date: 2.days.from_now)
      match_2 = create(:match, date: 3.days.from_now)

      actual_matches = MatchQueries.order_by_date_asc

      expect(actual_matches.first).to eq match_1
      expect(actual_matches.second).to eq match_2
      expect(actual_matches.third).to eq match_3
    end
  end

  describe '::order_by_position_asc' do

    it 'returns matches ordered by position asc' do
      match_3 = create(:match, position: 3)
      match_1 = create(:match, position: 1)
      match_2 = create(:match, position: 2)

      actual_matches = MatchQueries.order_by_position_asc

      expect(actual_matches.first).to eq match_1
      expect(actual_matches.second).to eq match_2
      expect(actual_matches.third).to eq match_3
    end
  end
end