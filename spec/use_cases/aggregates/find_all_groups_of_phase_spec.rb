describe FindAllGroupsOfPhase do

  let(:phase) { create(:phase) }
  let(:groups) {
    [
        create(:group, parent: phase, position: 3),
        create(:group, parent: phase, position: 1),
        create(:group, parent: phase, position: 2),
        create(:group, position: 1)
    ]
  }

  describe '#run' do

    context 'when given phase id has groups' do

      subject { FindAllGroupsOfPhase.new(phase.id) }

      it 'should set groups order by position to presentable' do

        actual_groups_of_phase = subject.run
        expect(actual_groups_of_phase).to eq [groups.second, groups.third, groups.first]
      end
    end

    context 'when given phase id has no groups' do

      subject { FindAllGroupsOfPhase.new(0) }

      it 'should set empty groups collection' do

        actual_groups_of_phase = subject.run
        expect(actual_groups_of_phase).to be_empty
      end
    end
  end
end