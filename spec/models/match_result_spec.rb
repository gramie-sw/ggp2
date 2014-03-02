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
      it { should validate_presence_of(:score_team_1)}
      it { should validate_numericality_of(:score_team_1).only_integer.is_greater_than_or_equal_to(0).is_less_than_or_equal_to(1000) }
    end

    describe '#score_team_2' do
      it { should validate_presence_of(:score_team_2)}
      it { should validate_numericality_of(:score_team_2).only_integer.is_greater_than_or_equal_to(0).is_less_than_or_equal_to(1000) }
    end
  end
end