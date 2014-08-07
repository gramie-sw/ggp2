describe TipsEditMultiplePresenter do

  let(:tips) { (1..3).map { |p| create(:tip, match: create(:match, position: p)) } }
  subject { TipsEditMultiplePresenter.new(tip_ids: tips.values_at(0, 1).map(&:id)) }

  describe '#initialize' do

    context 'if neither tip_ids or tips given' do

      it 'should raise error' do
        expect {
          TipsEditMultiplePresenter.new
        }.to raise_error
      end
    end
  end

  describe '#tip_presenters' do

    context 'if tip_ids given' do

      it 'should return all TipPresenters for tips of given ids' do
        actual_tip_presenters = subject.tip_presenters
        expect(actual_tip_presenters.count).to eq 2
        #be_kind_of matcher doesn't work with DelegateClass
        expect(actual_tip_presenters.first.kind_of?(TipPresenter)).to be_truthy
        expect(actual_tip_presenters.first.__getobj__).to eq tips.first
        expect(actual_tip_presenters.second.kind_of?(TipPresenter)).to be_truthy
        expect(actual_tip_presenters.second.__getobj__).to eq tips.second
      end

      describe 'chained scopes' do

        let(:relation) do
          relation = double('TipRelation')
          relation.as_null_object
          relation
        end

        before :each do
          expect(Tip).to receive(:where).and_return(relation)
        end

        it 'should includes match' do
          expect(relation).to receive(:includes).with(:match).and_return(relation)
          subject.tip_presenters
        end

        it 'should order tips by match position' do
          expect(relation).to receive(:order_by_match_position).and_return(relation)
          subject.tip_presenters
        end
      end

      it 'should cache TipPresenters' do
        expect(subject.tip_presenters).to be subject.tip_presenters
      end
    end

    context 'if tips given' do

      subject { TipsEditMultiplePresenter.new(tips: tips.values_at(0, 1)) }

      it 'should return TipPresenters for given tips' do
        actual_tip_presenters = subject.tip_presenters
        expect(actual_tip_presenters.count).to eq 2
        #be_kind_of matcher doesn't work with DelegateClass
        expect(actual_tip_presenters.first.kind_of?(TipPresenter)).to be_truthy
        expect(actual_tip_presenters.first.__getobj__).to eq tips.first
        expect(actual_tip_presenters.second.kind_of?(TipPresenter)).to be_truthy
        expect(actual_tip_presenters.second.__getobj__).to eq tips.second
      end
    end
  end
end