describe UserTipsShowPresenter do

  let(:user) { User.new(nickname: 'nickname_1') }
  let(:user_is_current_user) { true }
  let(:tournament) { Tournament.new }
  subject { UserTipsShowPresenter.new(user: user, tournament: tournament, user_is_current_user: user_is_current_user) }

  it_behaves_like 'ShowAllTipsOfAggregateForUserPresentable'
  it_behaves_like 'ShowChampionPresentable'
  it_behaves_like 'ShowAllPhasesPresentable'

  it { should respond_to(:user_is_current_user?) }
  it { should respond_to(:current_aggregate) }
  it { should respond_to(:phases) }

  describe '#title' do

    context 'if user is current_user' do
      it { subject.title.should eq t('tip.yours') }
    end

    context 'if user is not current_user' do
      let(:user_is_current_user) { false }
      it { subject.title.should eq t('tip.all') }
    end
  end

  describe '#subtitle' do

    context 'if user is current_user' do
      it { subject.subtitle.should eq '' }
    end

    context 'if user is not current_user' do
      let(:user_is_current_user) { false }
      it { subject.subtitle.should eq t('general.of_subject', subject: user.nickname) }
    end
  end

  describe '#show_as_form?' do

    let(:current_aggregate) { instance_double('Aggregate') }

    before :each do
      subject.current_aggregate = current_aggregate
    end

    context 'if user is current_user' do

      let(:user_is_current_user) { true }

      context 'if given aggregate has any future matches' do

        it 'should return true' do
          expect(current_aggregate).to receive(:has_future_matches?).and_return(true)
          expect(subject.show_as_form?).to be_true
        end
      end

      context 'if given aggregate has not any future matches' do

        it 'should return false' do
          expect(current_aggregate).to receive(:has_future_matches?).and_return(false)
          expect(subject.show_as_form?).to be_false
        end
      end
    end

    context 'if user is not current_user' do

      let(:user_is_current_user) { false }

      it 'should return false' do
        expect(subject.show_as_form?).to be_false
      end
    end
  end

  describe 'tip_presenters' do

    let(:tips) do
      [
          Tip.new,
          Tip.new
      ]
    end

    let(:user_is_current_user) { :user_is_current_user }

    before :each do
      subject.tips = tips
    end

    it 'should return TipPresenters for all set Tips with set user_is_current_user' do
      actual_tip_presenters = subject.tip_presenters
      expect(actual_tip_presenters.count).to eq 2
      expect(actual_tip_presenters.first).to be_instance_of(TipPresenter)
      expect(actual_tip_presenters.first.__getobj__).to be tips.first
      expect(actual_tip_presenters.first.is_for_current_user).to be user_is_current_user
    end
  end

  describe '#champion_tip_presenter' do

    it 'should return ChampionTipPresenter with set user_is_current_user' do
      actual_champion_tip_presenter = subject.champion_tip_presenter
      expect(actual_champion_tip_presenter).to be_instance_of(ChampionTipPresenter)
    end
  end

end