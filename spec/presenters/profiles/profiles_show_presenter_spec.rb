describe ProfilesShowPresenter do

  let(:user) { build(:player) }
  let(:is_for_current_user) { true }
  let(:tournament) { Tournament.new }
  subject { ProfilesShowPresenter.new(user: user, tournament: tournament, is_for_current_user: is_for_current_user) }

  it 'should respond to user' do
    subject.should respond_to :user
  end

  it 'should respond to is_for_current_user?' do
    subject.should respond_to :is_for_current_user?
  end

  describe '#user_statstic' do

    it 'should return player statistic for given user' do
      UserStatistic.should_receive(:new).with(user: user, tournament: tournament).and_call_original
      actual_user_statistic = subject.user_statistic
      actual_user_statistic.should be_kind_of UserStatistic
    end

    it 'should cache object' do
      subject.user_statistic.should be subject.user_statistic
    end
  end

end