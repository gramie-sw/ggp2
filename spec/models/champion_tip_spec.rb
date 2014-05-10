describe ChampionTip do

  it 'should have valid factory' do
    build(:champion_tip).should be_valid
  end

  it 'should include module ChampionTipRepository' do
    ChampionTip.included_modules.should include ChampionTipRepository
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

    context 'for base' do

      subject { create(:champion_tip) }

      context 'when tournament started' do

        it 'should validate no change' do
          expect_any_instance_of(Tournament).to receive(:started?).and_return(true)
          subject.team = create(:team)
          expect(subject).not_to be_valid
          subject.errors[:base].should include t('errors.messages.champion_tip_changeable_after_tournament_started')
        end
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
  end

  describe 'correct?' do

    context 'when result is correct' do

      it 'should return true' do
        subject.result = ChampionTip::RESULTS[:correct]
        subject.should be_correct
      end
    end

    context 'when result is incorrect' do

      it 'should return false' do
        subject.result = ChampionTip::RESULTS[:incorrect]
        subject.should_not be_correct
      end
    end
  end
end
