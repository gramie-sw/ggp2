describe UserTipsShowPresenter do

  let(:user) { create(:player) }
  subject { UserTipsShowPresenter.new(user: user, user_is_current_user: true) }

  describe '#title' do

    context 'if user is current_user' do
      it { subject.title.should eq t('general.your_tip.other') }
    end

    context 'if user is not current_user' do
      subject { UserTipsShowPresenter.new(user: user, user_is_current_user: false) }
      it { subject.title.should eq t('general.tips_of', name: user.nickname) }
    end
  end
end