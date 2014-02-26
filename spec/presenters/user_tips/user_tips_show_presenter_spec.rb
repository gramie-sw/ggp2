describe UserTipsShowPresenter do

  let(:user) { create(:player) }
  let(:user_is_current_user) { true }
  subject { UserTipsShowPresenter.new(user: user, user_is_current_user: user_is_current_user) }

  describe '#title' do

    context 'if user is current_user' do
      it { subject.title.should eq t('general.your_tip.other') }
    end

    context 'if user is not current_user' do
      let(:user_is_current_user) { false }
      it { subject.title.should eq t('general.tips_of', name: user.nickname) }
    end
  end

  describe '#show_as_form?' do

    let(:aggregate) { create(:aggregate) }

    context 'if user is not current_user' do
      let(:user_is_current_user) { false }
      it 'should return false' do
        subject.show_as_form?(aggregate).should be_false
      end
    end
  end

  describe '#tip_presenter_for' do

    let(:matches) do
      [
          create(:match),
          create(:match),
      ]
    end

    let(:tips) do
      [
          create(:tip, match: matches.first, user: user),
          create(:tip, match: matches.first),
          create(:tip, match: matches.second, user: user)
      ]
    end

    before :each do
      tips
    end

    it 'should return tip_presenter for given match and user' do
      actual_tip_presenter = subject.tip_presenter_for(matches.first)
      #rspec's be_kind_of matcher doesn't work for subclasses of DelegateClass
      actual_tip_presenter.kind_of?(TipPresenter).should be_true
      actual_tip_presenter.__getobj__.should eq tips.first
    end

    it 'should cache tip_presenter' do
      #rspec's be_kind_of matcher doesn't work for subclasses of DelegateClass when comparing objects directly
      subject.tip_presenter_for(matches.first).object_id.should be subject.tip_presenter_for(matches.first).object_id
    end
  end
end