describe TipPresenter do

  let(:tip) { create(:tip) }
  subject { TipPresenter.new(tip) }

  it 'should include ResultPresentable' do
    TipPresenter.included_modules.should include ResultPresentable
  end

  describe '#match_presenter' do

    it 'should return kind_of MatchPresenter for match of tip' do
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations 2.14.4
      subject.match_presenter.kind_of?(MatchPresenter).should be_true
      subject.match_presenter.match.should eq tip.match
    end

    it 'should cache created object' do
      #matcher be didn't worked with DelegateClass in rspec-expectations 2.14.4
      subject.match_presenter.object_id.should eq subject.match_presenter.object_id
    end
  end
end