describe ChampionTip, :type => :model do

  it 'should have valid factory' do
    expect(build(:champion_tip)).to be_valid
  end

  it 'should include module ChampionTipRepository' do
    expect(ChampionTip.included_modules).to include ChampionTipRepository
  end

  describe 'validations' do

    context 'for team' do

      context 'on create' do
        it { is_expected.not_to validate_presence_of(:team) }
      end

      context 'on update' do
        subject { create(:champion_tip) }
        it { is_expected.to validate_presence_of(:team) }
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:team) }
  end

  describe 'correct?' do

    context 'when result is correct' do

      it 'should return true' do
        subject.result = ChampionTip::RESULTS[:correct]
        expect(subject).to be_correct
      end
    end

    context 'when result is incorrect' do

      it 'should return false' do
        subject.result = ChampionTip::RESULTS[:incorrect]
        expect(subject).not_to be_correct
      end
    end
  end
end
