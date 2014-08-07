describe MatchResultPresenter do

  let(:match) { create(:match) }
  let(:match_result) { MatchResult.new(match_id: match.id) }
  subject { MatchResultPresenter.new(match_result) }

  describe '#match_presenter' do

    it 'should return MatchPresenter for wrapped match' do
      actual_match_presenter = subject.match_presenter
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations
      actual_match_presenter.kind_of?(MatchPresenter)
      expect(actual_match_presenter.__getobj__).to eq match
    end
  end
end