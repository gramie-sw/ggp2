describe ChampionTip do

  it 'should have valid factory' do
    build(:champion_tip).should be_valid
  end

  describe 'validations' do

    context 'for team' do

      context 'on create' do
        it { should_not validate_presence_of(:team) }
      end

      context 'on update' do
        subject { create(:champion_tip) }
        it { should validate_presence_of(:team) }
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
  end
end
