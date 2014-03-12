describe TipResultCalculator do

  describe '#result' do

    context 'if tip is correct' do

      let(:tip) { create(:tip, score_team_1: 1, score_team_2: 2) }
      let(:match) { create(:match, score_team_1: 1, score_team_2: 2) }
      subject { TipResultCalculator.new(match: match, tip: tip) }

      it 'should return tip result correct ' do
        subject.result.should eq Tip::RESULTS[:correct]
      end
    end

    context 'if tip is not correct' do

      let(:tip) { create(:tip, score_team_1: 1, score_team_2: 2) }
      let(:match) { create(:match, score_team_1: 2, score_team_2: 1) }
      subject { TipResultCalculator.new(match: match, tip: tip) }

      it 'should return tip result incorrect ' do
        subject.result.should eq Tip::RESULTS[:incorrect]
      end
    end

    context 'if tip has correct tendency' do

      let(:tip) { create(:tip, score_team_1: 1, score_team_2: 1) }
      let(:match) { create(:match, score_team_1: 2, score_team_2: 2) }
      subject { TipResultCalculator.new(match: match, tip: tip) }

      it 'should return tip result correct_tendency' do
        subject.result.should eq Tip::RESULTS[:correct_tendency]
      end
    end
  end
end