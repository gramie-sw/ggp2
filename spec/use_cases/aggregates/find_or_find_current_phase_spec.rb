describe Aggregates::FindOrFindCurrentPhase do

  subject { Aggregates::FindOrFindCurrentPhase }

  context 'if id is not nil' do

    let(:aggregate) { create(:phase) }

    it 'returns aggregate' do
      expect(subject.run(id: aggregate.to_param)).to eq aggregate
    end
  end

  context 'if id is nil' do

    it 'returns current phase' do
      expect(Aggregates::FindCurrentPhase).to receive(:run).and_return(:current_phase)
      expect(subject.run).to be :current_phase
    end
  end
end
