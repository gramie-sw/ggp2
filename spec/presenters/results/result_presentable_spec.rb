describe ResultPresentable do

  class TestClass
    include ResultPresentable

    def score_team_1;
    end

    def score_team_2;
    end
  end

  subject { TestClass.new }

  describe '#result' do

    context 'if match has result' do

      before :each do
        allow(subject).to receive(:score_team_1).and_return(1)
        allow(subject).to receive(:score_team_2).and_return(2)
      end

      context 'if hide_existing_result? returns true' do

        it 'should return existing result placeholder' do
          expect(subject).to receive(:hide_existing_result?).and_return(true)
          expect(subject.result).to eq '* : *'
        end
      end

      context 'if hide_existing_result returns false' do

        it 'should return formatted result' do
          expect(subject).to receive(:hide_existing_result?).and_return(false)
          expect(subject.result).to eq '1 : 2'
        end
      end
    end

    context 'if match has no result' do

      before :each do
        allow(subject).to receive(:score_team_1).and_return(nil)
        allow(subject).to receive(:score_team_2).and_return(nil)
      end

      it 'should return formatted result placeholder' do
        expect(subject.result).to eq '- : -'
      end
    end
  end

  describe '#hide_existing_result?' do

    it 'should return false' do
      expect(subject.hide_existing_result?).to be_falsey
    end
  end
end