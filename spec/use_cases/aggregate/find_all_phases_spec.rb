describe FindAllPhases do

  describe '#run' do

    it 'should return all phases ordered by position asc' do

      phase_3 = create(:phase, position: 4)
      phase_1 = create(:phase, position: 2)
      phase_2 = create(:phase, position: 3)
      create(:aggregate, parent: phase_1)

      actual_phases = subject.run
      expect(actual_phases).to eq [phase_1, phase_2, phase_3]
    end
  end
end