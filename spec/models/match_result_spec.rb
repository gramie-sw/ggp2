describe MatchResult, :type => :model do

  it 'should have valid factory' do
    expect(build(:match_result)).to be_valid
  end

  it 'should include module ScoreValidatable' do
    expect(MatchResult.included_modules).to include ScoreValidatable
  end

  describe 'validations' do
    describe '#validate_match_id' do
      it 'should be valid if for match_id exists a match' do
        match = create(:match)
        match_result = build(:match_result, match_id: match.id)
        expect(match_result.valid?).to be_truthy
      end

      it 'should not be valid with invalid error message if for match_id no match exists' do
        match_result = build(:match_result, match_id: 0)
        expect(match_result.valid?).to be_falsey
        expect(match_result.errors.get(:match_id).first).to eq I18n.t('errors.messages.invalid')
      end
    end
  end
end