describe TipResult do

  describe '::correct?' do
    let(:match) { build(:match, score_team_1: 1, score_team_2: 2) }

    context 'when it is a correct tip' do
      let(:tip) { build(:tip, score_team_1: 1, score_team_2: 2) }

      it 'should return true' do
        expect(subject.correct?(match, tip)).to be_true
      end
    end

    context 'when it is a tendency only correct tip' do
      let(:tip) { build(:tip, score_team_1: 1, score_team_2: 3) }

      it 'should return false' do
        expect(subject.correct?(match, tip)).to be_false
      end
    end

    context 'when it is a incorrect tip' do
      let(:tip) { build(:tip, score_team_1: 2, score_team_2: 1) }

      it 'should return false' do
        expect(subject.correct?(match, tip)).to be_false
      end
    end
  end

  describe '::correct tendency ?' do

    context 'when tip and match is a draw' do
      let(:match) { build(:match, score_team_1: 2, score_team_2: 2) }
      let(:tip) { build(:tip, score_team_1: 3, score_team_2: 3) }

      it 'should return true' do
        expect(subject.correct_tendency?(match, tip)).to be_true
      end
    end

    context 'when tip is not a draw and but match is' do
      let(:match) { build(:match, score_team_1: 2, score_team_2: 2) }
      let(:tip) { build(:tip, score_team_1: 3, score_team_2: 4) }

      it 'should return false' do
        expect(subject.correct_tendency?(match, tip)).to be_false
      end
    end

    context 'when tip and match score team 1 is larger than score team 2' do

      let(:match) { build(:match, score_team_1: 3, score_team_2: 2) }
      let(:tip) { build(:tip, score_team_1: 4, score_team_2: 1) }

      it 'should return true' do
        expect(subject.correct_tendency?(match, tip)).to be_true
      end
    end

    context 'when tip score team 1 is larger than score team 2 but match is different' do
      let(:match) { build(:match, score_team_1: 2, score_team_2: 2) }
      let(:tip) { build(:tip, score_team_1: 4, score_team_2: 1) }

      it 'should return false' do
        expect(subject.correct_tendency?(match, tip)).to be_false
      end
    end

    context 'when tip and match score team 1 is less than score team 2' do

      let(:match) { build(:match, score_team_1: 1, score_team_2: 2) }
      let(:tip) { build(:tip, score_team_1: 0, score_team_2: 1) }

      it 'should return true' do
        expect(subject.correct_tendency?(match, tip)).to be_true
      end
    end

    context 'when tip score team 1 is less than score team 2 but match is different' do
      let(:match) { build(:match, score_team_1: 1, score_team_2: 2) }
      let(:tip) { build(:tip, score_team_1: 4, score_team_2: 1) }

      it 'should return false' do
        expect(subject.correct_tendency?(match, tip)).to be_false
      end
    end
  end
end