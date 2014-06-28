describe ShowAllGroupsOfPhase do

  let(:phase) { create(:phase) }
  let(:groups) {
    [
        create(:group, parent: phase, position: 3),
        create(:group, parent: phase, position: 1),
        create(:group, parent: phase, position: 2),
        create(:group, position: 1)
    ]
  }

  let(:presentable) { double('Presentable') }

  describe '#run_with_presentable' do

    context 'when given phase id has groups' do
      subject { ShowAllGroupsOfPhase.new(phase.id) }

      it 'should set groups order by position to presentable' do

        expect(presentable).to receive(:groups=) do |actual_groups|
          expect(actual_groups).to eq [groups.second, groups.third, groups.first]
        end

        subject.run_with_presentable(presentable)
      end
    end

    context 'when given phase id has no groups' do

      subject { ShowAllGroupsOfPhase.new(0) }

      it 'should set empty groups collection' do

        expect(presentable).to receive(:groups=) do |actual_groups|
          expect(actual_groups).to be_empty
        end

        subject.run_with_presentable(presentable)
      end
    end
  end

end