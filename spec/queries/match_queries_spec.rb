describe MatchQueries do

  subject { MatchQueries }

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
end