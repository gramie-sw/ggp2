describe ShowAllPhases do

  describe '#run_with_presentable' do

    let(:presentable) { double(:presentable) }

    it 'should set all phases ordered by position asc to presentable' do
      phase_3 = create(:phase, position: 4)
      phase_1 = create(:phase, position: 2)
      phase_2 = create(:phase, position: 3)
      create(:aggregate, parent: phase_1)

      expect(presentable).to receive(:phases=) do |actual_phases|
        expect(actual_phases).to eq [phase_1, phase_2, phase_3]
      end

      subject.run_with_presentable(presentable)
    end
  end
end