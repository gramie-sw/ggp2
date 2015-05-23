describe UserTipsPresenter do

  let(:user) { User.new(id: 34, nickname: 'nickname_1') }
  let(:current_aggregate) { Aggregate.new(id: 345) }
  let(:user_is_current_user) { true }
  let(:tournament) { Tournament.new }

  subject do
    UserTipsPresenter.new(
        user: user,
        current_aggregate: current_aggregate,
        tournament: tournament,
        user_is_current_user: user_is_current_user)
  end


  it { is_expected.to be_kind_of(MatchSchedulePresenter) }
  it { is_expected.to respond_to(:user_is_current_user?) }

  describe '#title' do

    context 'if user is current_user' do
      it { expect(subject.title).to eq t('tip.yours') }
    end

    context 'if user is not current_user' do
      let(:user_is_current_user) { false }
      it { expect(subject.title).to eq t('tip.all') }
    end
  end

  describe '#subtitle' do

    context 'if user is current_user' do
      it { expect(subject.subtitle).to eq '' }
    end

    context 'if user is not current_user' do
      let(:user_is_current_user) { false }
      it { expect(subject.subtitle).to eq t('general.of_subject', subject: user.nickname) }
    end
  end


  describe '#show_as_form?' do

    context 'if user is current_user' do

      let(:user_is_current_user) { true }

      context 'if given aggregate has any future matches' do

        it 'should return true' do
          expect(current_aggregate).to receive(:has_future_matches?).and_return(true)
          expect(subject.show_as_form?).to be_truthy
        end
      end

      context 'if given aggregate has not any future matches' do

        it 'should return false' do
          expect(current_aggregate).to receive(:has_future_matches?).and_return(false)
          expect(subject.show_as_form?).to be_falsey
        end
      end
    end

    context 'if user is not current_user' do

      let(:user_is_current_user) { false }

      it 'should return false' do
        expect(subject.show_as_form?).to be_falsey
      end
    end
  end

  describe '#tip_presenters' do

    let(:tips) { [Tip.new, Tip.new] }

    it 'should return TipPresenters for all tips of current_aggregate and user' do
      expect(Tip).to receive(:all_eager_by_user_id_and_aggregate_id_ordered_by_position).
                          with(user.id, current_aggregate.id).and_return(tips)

      expect(TipPresenter).to receive(:new).
                                  with(tip: tips.first, is_for_current_user: user_is_current_user).
                                  and_return(:presenter_1)
      expect(TipPresenter).to receive(:new).
                                  with(tip: tips.second, is_for_current_user: user_is_current_user).
                                  and_return(:presenter_2)

      expect(subject.tip_presenters).to eq [:presenter_1, :presenter_2]
    end
  end

  describe '#champion_tip_presenter' do

    let(:champion_tip) { ChampionTip.new }

    it 'returns ChampionTipPresenter with champion_tip of given user' do
      expect(ChampionTip).to receive(:find_by_user_id).with(user.id).and_return(champion_tip)
      expect(ChampionTipPresenter).to receive(:new).with(
                                          tournament: tournament,
                                          champion_tip: champion_tip,
                                          user_is_current_user: user_is_current_user
                                      ).and_return(:presenter)

      expect(subject.champion_tip_presenter).to be :presenter
    end
  end

end