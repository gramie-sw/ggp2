describe TipPresenter do

  let(:tip) { create(:tip) }
  subject { TipPresenter.new(tip) }

  describe '#match_presenter' do

    it 'should return MatchPresenter for match of tip' do
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations 2.14.4
      subject.match_presenter.kind_of?(MatchPresenter).should be_true
      subject.match_presenter.match.should be tip.match
    end

    #it 'should cache MatchPresenter' do
    #  subject.match_presenter.should be subject.match_presenter
    #end
  end

end