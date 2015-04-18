describe Aggregates::FindCurrentPhase do

  let(:expected_phase) { create(:phase) }
  let(:group) { create(:group, parent: expected_phase) }

  subject { Aggregates::FindCurrentPhase }

  context 'if their is a next match' do

    it 'returns phase of next match' do
      create(:match, position: 1, date: 1.day.ago)
      create(:match, position: 2, date: 1.day.from_now, aggregate: expected_phase)

      expect(subject.run).to eq expected_phase
    end

    context 'if next match belongs to group' do

      it 'returns phase of the group of next match' do
        create(:match, position: 1, date: 1.day.ago)
        create(:match, position: 2, date: 1.day.from_now, aggregate: group)

        expect(subject.run).to eq expected_phase
      end
    end
  end

  context 'if their is not a next match' do

    it 'returns phase of last match' do
      create(:match, position: 2, date: 1.day.ago, aggregate: expected_phase)
      create(:match, position: 1, date: 2.day.ago)

      expect(subject.run).to eq expected_phase
    end

    context 'if last match belongs to group' do

      it 'returns phase of the group of last match' do
        create(:match, position: 2, date: 1.day.ago, aggregate: group)
        create(:match, position: 1, date: 2.day.ago)

        expect(subject.run).to eq expected_phase
      end
    end
  end

  context 'if there are no matches at all' do

    it 'returns nil' do
      expect(subject.run).to be_nil
    end
  end
end