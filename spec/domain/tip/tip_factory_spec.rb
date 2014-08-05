describe TipFactory do

  let(:match_repository) { Match }
  subject { TipFactory.new(match_repository) }

  describe '#build_all' do
    it 'should return build Tips for every Match' do
      match_repository.stub(:all).and_return ([Match.new(id: 12), Match.new(id: 13)])
      actual_tips = subject.build_all

      actual_tips.size.should eq 2
      actual_tips.first.match_id.should eq 12
      actual_tips.last.match_id.should eq 13
    end
  end
end
