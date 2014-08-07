describe TipPresenter do

  let(:tip) { create(:tip) }
  let(:is_for_current_user) { true }
  subject { TipPresenter.new(tip: tip, is_for_current_user: is_for_current_user) }

  it {is_expected.to respond_to :is_for_current_user}

  it 'should include ResultPresentable' do
    expect(TipPresenter.included_modules).to include ResultPresentable
  end

  describe '#points' do

    context 'if points present' do

      it 'should return the points' do
        tip.result = Tip::RESULTS[:correct]
        expect(subject.points).to eq Ggp2.config.correct_tip_points
      end
    end

    context 'if points not present' do

      it 'should return the -' do
        allow(tip).to receive(:points).and_return(nil)
        expect(subject.points).to eq '-'
      end
    end
  end

  describe '#hide_existing_result?' do

    let(:is_for_current_user) { false }

    before :each do
      allow(tip).to receive(:tippable?).and_return(true)
    end

    context 'if is_for_current_user is false and tip is tippable' do

      it 'should return true' do
        expect(subject.hide_existing_result?).to be_truthy
      end
    end

    context 'if is_for_current_user is true' do

      let(:is_for_current_user) { true }

      it 'should return false' do
        expect(subject.hide_existing_result?).to be_falsey
      end
    end

    context 'if tip is not tippable anymore' do

      it 'should return false' do
        allow(tip).to receive(:tippable?).and_return(false)
        expect(subject.hide_existing_result?).to be_falsey
      end
    end

  end

  describe '#match_presenter' do

    it 'should return kind_of MatchPresenter for match of tip' do
      #matcher be_kind_of didn't worked with DelegateClass in rspec-expectations
      expect(subject.match_presenter.kind_of?(MatchPresenter)).to be_truthy
      expect(subject.match_presenter.__getobj__).to eq tip.match
    end

    it 'should cache created object' do
      #matcher be didn't worked with DelegateClass in rspec-expectations
      expect(subject.match_presenter.object_id).to eq subject.match_presenter.object_id
    end
  end
end