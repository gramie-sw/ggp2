describe ProfilesShowPresenter do

  let(:user) { build(:player) }
  let(:current_user_id) { user.id }
  subject { ProfilesShowPresenter.new(user: user, current_user_id: current_user_id) }

  it 'should respond to user' do
    subject.should respond_to :user
  end

  describe '#user_statstic' do

    it 'should return player statistic for given user' do
      actual_user_statistic = subject.user_statistic
      actual_user_statistic.should be_kind_of UserStatistic
      actual_user_statistic.user.should eq user
    end

    it 'should cache object' do
      subject.user_statistic.should be subject.user_statistic
    end
  end
  
end