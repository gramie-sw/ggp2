describe AggregateRepository do

  subject { Aggregate }

  describe '::all_phased_ordered_by_position_asc' do

    it 'should return all phases ordered by position asc' do
      phase_3 = create(:phase, position: 4)
      phase_1 = create(:phase, position: 2)
      phase_2 = create(:phase, position: 3)
      create(:aggregate, parent: phase_1)

      actual_phases = subject.all_phased_ordered_by_position_asc
      expect(actual_phases).to eq [phase_1, phase_2, phase_3]
    end
  end

  describe '::all_ordered_by_position_asc_recursive' do

    it 'should return all aggregrate ordered by position recursively' do
      phase_3 = create(:phase, position: 3)
      phase_1 = create(:phase, position: 1)
      phase_2 = create(:phase, position: 2)
      group_3 = create(:group, position: 3, parent: phase_2)
      group_1 = create(:group, position: 1, parent: phase_2)
      group_2 = create(:group, position: 2, parent: phase_2)

      actual_aggregates = subject.all_ordered_by_position_asc_recursive
      expect(actual_aggregates.count).to eq 6
    end
  end

  describe 'all_groups_by_phase_id' do

    it 'should return groups with given phase id ordered by given sort' do
      phase = create(:phase)
      group_3 = create(:group, parent: phase, position: 3)
      group_1 = create(:group, parent: phase, position: 1)
      group_2 = create(:group, parent: phase, position: 2)
      create(:group, position: 1)

      actual_groups = subject.all_groups_by_phase_id(phase_id: phase.id, sort: :position)
      expect(actual_groups).to eq [group_1, group_2, group_3]
    end
  end
end