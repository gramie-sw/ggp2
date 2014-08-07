describe TipFactory do

  let(:match_repository) { Match }
  subject { TipFactory.new(match_repository) }

  describe '#build_all' do
    it 'should return build Tips for every Match' do
      allow(match_repository).to receive(:all).and_return ([Match.new(id: 12), Match.new(id: 13)])
      actual_tips = subject.build_all

      expect(actual_tips.size).to eq 2
      expect(actual_tips.first.match_id).to eq 12
      expect(actual_tips.last.match_id).to eq 13
    end
  end
end
