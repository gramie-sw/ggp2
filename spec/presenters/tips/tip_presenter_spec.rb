describe TipPresenter do

  let(:tip) { create(:tip) }
  let(:is_for_current_user) { true }
  subject { TipPresenter.new(tip: tip, is_for_current_user: is_for_current_user) }

  it 'should include ResultPresentable' do
    TipPresenter.included_modules.should include ResultPresentable
  end

  describe '#points' do

    context 'if points present' do

      it 'should return the points' do
        tip.points = 5
        subject.points.should eq 5
      end
    end

    context 'if points not present' do

      it 'should return the -' do
        tip.points = nil
        subject.points.should eq '-'
      end
    end
  end

  describe '#match_presenter' do

    it 'should return kind_of MatchPresenter for match of tip' do
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations 2.14.4
      subject.match_presenter.kind_of?(MatchPresenter).should be_true
      subject.match_presenter.__getobj__.should eq tip.match
    end

    it 'should cache created object' do
      #matcher be didn't worked with DelegateClass in rspec-expectations 2.14.4
      subject.match_presenter.object_id.should eq subject.match_presenter.object_id
    end
  end
end