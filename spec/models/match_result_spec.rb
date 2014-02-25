describe MatchResult do

  it 'should have valid factory' do
    build(:match_result).should be_valid
  end

  describe 'validations' do
    describe '#validate_match_id' do
      it 'should be valid if for match_id exists a match' do
        match = create(:match)
        match_result = build(:match_result, match_id: match.id)
        match_result.valid?.should be_true
      end

      it 'should not be valid with invalid error message if for match_id no match exists' do
        match_result = build(:match_result, match_id: 0)
        match_result.valid?.should be_false
        match_result.errors.get(:match_id).first.should eq I18n.t('errors.messages.invalid')
      end
    end

    describe '#score_team_1' do
      it { should validate_numericality_of(:score_team_1).only_integer }
      it { should ensure_inclusion_of(:score_team_1).in_range(0..1000).allow_nil }
    end

    describe '#score_team_2' do
      it { should validate_numericality_of(:score_team_2).only_integer }
      it { should ensure_inclusion_of(:score_team_2).in_range(0..1000).allow_nil }
    end
  end
end