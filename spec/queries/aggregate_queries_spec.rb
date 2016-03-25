describe AggregateQueries do

  describe '::all_groups_by_phase_id' do

    it 'returns groups with given phase id ordered by given sort' do
      phase = create(:phase)
      group_3 = create(:group, parent: phase, position: 3)
      group_1 = create(:group, parent: phase, position: 1)
      group_2 = create(:group, parent: phase, position: 2)
      create(:group, position: 1)

      actual_groups = subject.all_groups_by_phase_id(phase_id: phase.id, sort: :position)
      expect(actual_groups).to eq [group_1, group_2, group_3]
    end
  end

  describe '::all_phases_ordered_by_position_asc' do

    it 'return all phases ordered by position asc' do
      phase_3 = create(:phase, position: 4)
      phase_1 = create(:phase, position: 2)
      phase_2 = create(:phase, position: 3)
      create(:aggregate, parent: phase_1)

      actual_phases = subject.all_phases_ordered_by_position_asc
      expect(actual_phases).to eq [phase_1, phase_2, phase_3]
    end
  end
end