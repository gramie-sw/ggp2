describe TipResultCalculator do

  describe '::calculate' do

    let(:match) { double 'match'}
    let(:tip) { double 'tip'}

    context 'when tip is correct' do

      it 'should return tip result correct ' do
        expect(TipResult).to receive(:correct?).with(any_args).and_return(true)
        expect(subject.calculate(match, tip)).to eq Tip::RESULTS[:correct]
      end
    end

    context 'when tip has correct tendency' do

      it 'should return tip result correct tendency only' do
        expect(TipResult).to receive(:correct?).with(any_args).and_return(false)
        expect(TipResult).to receive(:correct_tendency?).with(any_args).and_return(true)

        expect(subject.calculate(match, tip)).to eq Tip::RESULTS[:correct_tendency_only]
      end
    end

    context 'when tip is not correct' do

      it 'should return tip result incorrect' do
        expect(TipResult).to receive(:correct?).with(any_args).and_return(false)
        expect(TipResult).to receive(:correct_tendency?).with(any_args).and_return(false)

        expect(subject.calculate(match, tip)).to eq Tip::RESULTS[:incorrect]
      end
    end
  end
end