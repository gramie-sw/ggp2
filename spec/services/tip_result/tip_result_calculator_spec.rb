describe TipResultCalculator do

  subject { TipResultCalculator }

  describe '::result' do

    let(:match) { create(:match, score_team_1: 1, score_team_2: 2) }

    context 'if tip is correct' do
      let(:tip) { create(:tip, score_team_1: 1, score_team_2: 2) }

      it 'should return tip result correct ' do
        subject.result(tip: tip, match: match).should eq Tip::RESULTS[:correct]
      end
    end

    context 'if tip is not correct' do
      let(:tip) { create(:tip, score_team_1: 2, score_team_2: 2) }

      it 'should return tip result incorrect ' do
        subject.result(tip: tip, match: match).should eq Tip::RESULTS[:incorrect]
      end
    end

    context 'if tip has correct tendency' do
      let(:tip) { create(:tip, score_team_1: 1, score_team_2: 4) }

      it 'should return tip result correct_tendency' do
        subject.result(tip: tip, match: match).should eq Tip::RESULTS[:correct_tendency_only]
      end
    end
  end

  describe '::correct?' do
    let(:match) { create(:match, score_team_1: 1, score_team_2: 2)}

    context 'if it has correct tip' do
      let(:tip) { create(:tip, score_team_1: 1, score_team_2: 2)}

      it'should return true' do
        subject.correct?(match: match, tip: tip).should be_true
      end
    end

    context 'if it has incorrect tip' do
      let(:tip) { create(:tip, score_team_1: 2, score_team_2: 1)}

      it 'should return false' do
        subject.correct?(match: match, tip: tip).should be_false
      end
    end
  end

  describe '::correct tendency?' do

    context 'if tip and match is a draw' do
      let(:match) { create(:match, score_team_1: 2, score_team_2: 2)}
      let(:tip) { create(:tip, score_team_1: 3, score_team_2: 3)}

      it 'should return true' do
        subject.correct_tendency?(match: match, tip: tip).should be_true
      end
    end

    context 'if tip is not a draw and but match is' do
      let(:match) { create(:match, score_team_1: 2, score_team_2: 2)}
      let(:tip) { create(:tip, score_team_1: 3, score_team_2: 4)}

      it 'should return false' do
        subject.correct_tendency?(match: match, tip: tip).should be_false
      end
    end

    context 'if tip and match score team 1 is larger than score team 2' do

      let(:match) { create(:match, score_team_1: 3, score_team_2: 2)}
      let(:tip) { create(:tip, score_team_1: 4, score_team_2: 1)}

      it 'should return true' do
        subject.correct_tendency?(match: match, tip: tip).should be_true
      end
    end

    context 'if tip score team 1 is larger than score team 2 but match is different' do
      let(:match) { create(:match, score_team_1: 2, score_team_2: 2)}
      let(:tip) { create(:tip, score_team_1: 4, score_team_2: 1)}

      it 'should return false' do
        subject.correct_tendency?(match: match, tip: tip).should be_false
      end
    end

    context 'if tip and match score team 1 is less than score team 2' do

      let(:match) { create(:match, score_team_1: 1, score_team_2: 2)}
      let(:tip) { create(:tip, score_team_1: 0, score_team_2: 1)}

      it 'should return true' do
        subject.correct_tendency?(match: match, tip: tip).should be_true
      end
    end

    context 'if tip score team 1 is less than score team 2 but match is different' do
      let(:match) { create(:match, score_team_1: 1, score_team_2: 2)}
      let(:tip) { create(:tip, score_team_1: 4, score_team_2: 1)}

      it 'should return false' do
        subject.correct_tendency?(match: match, tip: tip).should be_false
      end
    end
  end
end